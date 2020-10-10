class AddPetsToShelters < ActiveRecord::Migration[5.2]
  def change
    add_reference :shelters, :pet, foreign_key: true
  end
end
