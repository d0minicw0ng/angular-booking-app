class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :masseur_id, null: false
      t.integer :customer_id, null: false

      t.timestamps
    end
  end
end
