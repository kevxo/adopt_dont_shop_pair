require 'rails_helper'

describe 'As a visitor' do
  describe "When I visit '/shelters/:id' " do
    it "should display the shelter's id and information" do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')

      visit "/shelters/#{shelter1.id}"

      expect(page).to have_content(shelter1.id.to_s)
      expect(page).to have_content(shelter1.name.to_s)
      expect(page).to have_content(shelter1.address.to_s)
      expect(page).to have_content(shelter1.city.to_s)
      expect(page).to have_content(shelter1.state.to_s)
      expect(page).to have_content(shelter1.zip.to_s)
    end
  end
end

describe 'As a visitor' do
  describe 'When I visit a shelter show page' do
    it "should see a link 'Update shelter'" do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')

      visit "/shelters/#{shelter1.id}"
      expect(page).to have_link('Update Shelter')

      visit "/shelters/#{shelter1.id}"
      click_link 'Update Shelter'

      expect(current_path).to eq("/shelters/#{shelter1.id}/edit")
    end
  end
end

describe 'As a visitor' do
  describe 'When I visit a shelter show page' do
    it 'should see a button to delete the shelter' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')

      visit "/shelters/#{shelter1.id}"

      expect(page).to have_button('Delete Shelter')
    end
  end
end

describe 'As a visitor' do
  describe 'When I visit the shelter show page' do
    it 'should see a link that takes me to the Shelters Pet Index page' do
      shelter1 = Shelter.create(name: 'Dogs and Cats',
                                address: '1234 spoon.st',
                                city: 'Tampa',
                                state: 'Florida',
                                zip: '34638')
      visit "/shelters/#{shelter1.id}"

      expect(page).to have_link('Pet Index')

      visit "/shelters/#{shelter1.id}"

      click_link 'Pet Index'

      expect(current_path).to eq("/shelters/#{shelter1.id}/pets")
    end
  end
end

describe 'As a visitor' do
  describe 'When I visit a shelters show page' do
    it 'should show a list of reviews for that shelter' do
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
      user2 = User.create!(name: 'Tony',
                           street_address: '1234 Review Dr',
                           city: 'Denver',
                           state: 'Colorado',
                           zip: '19345')
      review1 = Review.create!(title: 'My Rating',
                               rating: 3,
                               content: 'review',
                               shelter_id: shelter1.id,
                               user_id: user1.id,
                               name: user1.name)
      review2 = Review.create!(title: 'My thoughts',
                               rating: 4,
                               content: 'Great place for pets',
                               shelter_id: shelter1.id,
                               user_id: user2.id,
                               name: user2.name)
      visit "/shelters/#{shelter1.id}"

      expect(page).to have_content(review1.title)
      expect(page).to have_content(review1.rating.to_s)
      expect(page).to have_content(review1.content)
      expect(page).to_not have_xpath("//img[contains(@src,'#{review1.picture}')]")
      expect(page).to have_content(review1.name)
      expect(page).to have_content(review2.title)
      expect(page).to have_content(review2.rating.to_s)
      expect(page).to have_content(review2.content)
      expect(page).to_not have_xpath("//img[contains(@src,'#{review1.picture}')]")
      expect(page).to have_content(review2.name)
    end
  end
end
