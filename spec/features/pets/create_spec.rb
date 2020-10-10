require 'rails_helper'

describe "When I have clicked the link 'Create Pet'" do
  it "I should see a form to fill out the pets information
  and when I click the 'Create Pet' button. The pet has a status of adoptable. I should
  be redirected back to Shelters Pets Index" do
    shelter1 = Shelter.create(name: 'Dogs and Cats',
                              address: '1234 spoon.st',
                              city: 'Tampa',
                              state: 'Florida',
                              zip: '34638')
    visit "/shelters/#{shelter1.id}/pets/new"

    fill_in 'pet[image]',	with: 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Hell-hound_Link_%289090238332%29.jpg'
    fill_in 'pet[name]',	with: 'Lucy'
    fill_in 'pet[description]',	with: 'Demon eyes and ruffled tongue'
    fill_in 'pet[approximate_age]',	with: '2 years'
    fill_in 'pet[sex]',	with: 'Female'

    click_button 'Create Pet'
    expect(page).to have_xpath("//img[contains(@src,'https://upload.wikimedia.org/wikipedia/commons/f/f0/Hell-hound_Link_%289090238332%29.jpg')]")
    expect(page).to have_content('Lucy')
    expect(page).to have_content('Demon eyes and ruffled tongue')
    expect(page).to have_content('2 years')
    expect(page).to have_content('Female')
    expect(current_path).to eq("/shelters/#{shelter1.id}/pets")
  end
end
