class RemoveShelterIdFromPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :shelter_id, :string
  end
end
