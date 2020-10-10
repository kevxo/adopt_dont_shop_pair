require 'rails_helper'

# User Story 11, Pet Update

# I am taken to '/pets/:id/edit' where I see a form to edit the pet's data including:
# - image
# - name
# - description
# - approximate age
# - sex
# When I click the button to submit the form "Update Pet"
# Then a `PATCH` request is sent to '/pets/:id',
# the pet's data is updated,
# and I am redirected to the Pet Show page where I see the Pet's updated information

describe "When I'm taken to '/pets/:id/edit'" do
  it 'should see a form to edit the pets data' do
    shelter1 = Shelter.create(name: 'Dogs and Cats',
                              address: '1234 spoon.st',
                              city: 'Tampa',
                              state: 'Florida',
                              zip: '34638')
    pet2 = Pet.create(image: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg',
                      name: 'Tiger',
                      approximate_age: '4 years',
                      sex: 'Male',
                      shelters_id: shelter1.id)

    visit "/pets/#{pet2.id}/edit"

    fill_in 'pet[image]',	with: 'https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg'
    fill_in 'pet[name]',	with: 'Tiger'
    fill_in 'pet[description]',	with: 'Small and Cute'
    fill_in 'pet[approximate_age]',	with: '2 years'
    fill_in 'pet[sex]',	with: 'Male'
    click_button 'Update Pet'

    expect(page).to have_content('Tiger')
    expect(current_path).to eq("/pets/#{pet2.id}")
  end
end
