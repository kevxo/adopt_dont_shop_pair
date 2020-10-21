require 'rails_helper'

describe "When I visit a pet show page and click on 'Delete Pet'" do
  it 'when I click Im redirected to pet index page' do
    shelter1 = Shelter.create(name: 'Dogs and Cats',
                              address: '1234 spoon.st',
                              city: 'Tampa',
                              state: 'Florida',
                              zip: '34638')
    pet1 = Pet.create(img: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/June_odd-eyed-cat.jpg',
                      name: 'Mittens',
                      description: "He's healthy",
                      approximate_age: '6 years',
                      sex: 'Male',
                      adoptable: 'Yes',
                      shelter_id: shelter1.id)

    pet_2 = shelter1.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg",
                                  name: "Isabell",
                                  approximate_age: "5",
                                  sex: "female",
                                  description: "Isabell is my favorite and I don't want her to go...but then again, I do!")

    visit "/pets/#{pet1.id}"
    click_button 'Delete Pet'

    expect(current_path).to eq('/pets')
    expect(page).to_not have_css("#pet-#{pet1.id}")
    expect(page).to have_css("#pet-#{pet_2.id}")
  end
end
