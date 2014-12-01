class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  belongs_to :company
  has_many :jobs, class_name: "Appointment", foreign_key: :masseur_id
  has_many :appointments, foreign_key: :customer_id

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_inclusion_of :role, in: %w(admin manager staff customer)

  # TODO: Do we keep phone_number or do we not?
  phony_normalize :mobile_phone_number, default_country_code: "ID"
  validates :mobile_phone_number, phony_plausible: true, if: Proc.new { |user| user.mobile_phone_number.present? }

  def mobile_phone_number_formatted
    mobile_phone_number.try(:phony_formatted, { format: :international, space: "-" })
  end

  def name
    "#{first_name} #{last_name}"
  end

  # TODO: more attributes
  # address
  # department / type
  # emergency contact
  # photo
  # pay rate
  # maybe start date/ hire date?

  def serializable_hash options
    # NOTE: devise overrides serializable_hash and we have
    # merge whatever we want in the JSON object.
    super(options).merge(
      name: name,
      mobile_phone_number_formatted: mobile_phone_number_formatted
    )
  end

end
