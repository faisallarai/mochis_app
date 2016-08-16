class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :last_name
      t.string :first_name
      t.string :dob
      t.string :phone_number
      t.string :email_address
      t.timestamps
    end
  end
end
