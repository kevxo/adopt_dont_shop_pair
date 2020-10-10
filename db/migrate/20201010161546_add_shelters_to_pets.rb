class AddSheltersToPets < ActiveRecord::Migration[5.2]
  def change
    add_reference :pets, :shelters, foreign_key: true
  end
end
