class CreateCompanies < ActiveRecord::Migration
  def up
    create_table :companies do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_column :users, :company_id, :integer
  end

  def down
    drop_table :companies
    remove_column :users, :company_id
  end
end
