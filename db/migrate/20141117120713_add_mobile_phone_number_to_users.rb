class AddMobilePhoneNumberToUsers < ActiveRecord::Migration
  def up
    add_column :users, :mobile_phone_number, :string
  end

  def down
    remove_column :users, :mobile_phone_number
  end
end
