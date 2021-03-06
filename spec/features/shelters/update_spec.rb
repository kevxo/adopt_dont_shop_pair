require 'rails_helper'

describe "When I have clicked the button 'Update Shelter'" do
  it "should present a form where I can edit shelter's data and should have button
  where I am redirected to show" do
    shelter1 = Shelter.create(name: 'Dogs and Cats',
                              address: '1234 spoon.st',
                              city: 'Tampa',
                              state: 'Florida',
                              zip: '34638')

    visit "/shelters/#{shelter1.id}/edit"

    fill_in 'name', with: 'Dogs'
    fill_in 'address', with: '1234 spoon.st'
    fill_in 'city', with: 'Miami'
    fill_in 'state', with: 'Florida'
    fill_in 'zip', with: '12345'
    click_button 'Submit'

    expect(page).to have_content('Dogs')
    expect(current_path).to eq("/shelters/#{shelter1.id}")
  end
end
