class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :user_name
      t.string :address
      t.text :description
      t.string :pet_names
      t.string :application_status
    end
  end
end
