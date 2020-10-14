require 'rails_helper'

describe "When I have clicked the button 'New Shelter' " do
  describe 'User can the form to fill out' do
    it 'should fill out the form for the new shelter and click
    create shelter and be redirected back to shelters' do
      visit '/shelters/new'

      fill_in 'shelter[name]', with: 'Dog and Cats'
      fill_in 'shelter[address]', with: '1234 spoon.st'
      fill_in 'shelter[city]', with: 'Tampa'
      fill_in 'shelter[state]', with: 'Florida'
      fill_in 'shelter[zip]', with: '34638'

      click_button 'Create Shelter'
      expect(page).to have_content('Dog and Cats')
      expect(page).to have_content('1234 spoon.st')
      expect(page).to have_content('Tampa')
      expect(page).to have_content('Florida')
      expect(page).to have_content('34638')
      expect(current_path).to eq('/shelters')
    end
  end
end

describe "When I click 'New Review'" do
  it 'should take me to a page where I need to enter review info' do
    shelter1 = Shelter.create!(name: 'Dogs and Cats',
                               address: '1234 spoon.st',
                               city: 'Tampa',
                               state: 'Florida',
                               zip: '34638')
    user1 = User.create!(name: 'Bob',
                         street_address: '1234 Test Dr',
                         city: 'Denver',
                         state: 'Colorado',
                         zip: '12345')
    review1 = Review.create!(title: 'My Rating',
                             rating: 3,
                             content: 'The place is not bad.',
                             picture: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Bob_Gibson_crop.JPG',
                             shelter_id: shelter1.id,
                             user_id: user1.id,
                             name: user1.name)
    visit "/shelters/#{shelter1.id}/reviews/new"

    fill_in 'review[title]',	with: 'My opinion'
    fill_in 'review[name]',	with: user1.name
    fill_in 'review[rating]',	with: 4
    fill_in 'review[content]',	with: 'The place is great. Customer service is awesome.'
    fill_in 'review[picture]',	with: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Bob_Gibson_crop.JPG'

    click_button 'Submit Review'
    expect(page).to have_content('My Opinion')
    expect(page).to have_content(user1.name)
    expect(page).to have_content(4)
    expect(page).to have_content('The place is great. Customer service is awesome.')
    expect(page).to have_xpath("//img[contains(@src,'https://upload.wikimedia.org/wikipedia/commons/6/6a/Bob_Gibson_crop.JPG')]")
    expect(current_path).to eq("/shelters/#{shelter1.id}")
  end
end
