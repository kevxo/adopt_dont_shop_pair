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
      shelter2 = Shelter.create!(name: 'Pets for You',
                                 address: '1234 test.st',
                                 city: 'Miami',
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
                               content: 'The place is not bad.',
                               picture: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Bob_Gibson_crop.JPG',
                               shelter_id: shelter1.id,
                               user_id: user1.id,
                               name: user1.name)
      review2 = Review.create!(title: 'My thoughts',
                               rating: 4,
                               content: 'Great place for pets',
                               picture: 'https://upload.wikimedia.org/wikipedia/commons/4/4e/Tony_Romo_2015.jpg',
                               shelter_id: shelter2.id,
                               user_id: user2.id,
                               name: user2.name)
      review3 = Review.create!(title: 'My Rating',
                               rating: 3,
                               content: 'Its okay. Cute pets they have.',
                               picture: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Bob_Gibson_crop.JPG',
                               shelter_id: shelter1.id,
                               user_id: user1.id,
                               name: user1.name)
      review4 = Review.create!(title: 'My Concerns',
                               rating: 2,
                               content: 'This place is not great',
                               picture: 'https://upload.wikimedia.org/wikipedia/commons/4/4e/Tony_Romo_2015.jpg',
                               shelter_id: shelter2.id,
                               user_id: user2.id,
                               name: user2.name)

      visit "/shelters/#{shelter1.id}"
      expect(page).to have_content(review1.title)
      expect(page).to have_content(review1.rating.to_s)
      expect(page).to have_content(review1.content)
      expect(page).to have_xpath("//img[contains(@src,'#{review1.picture}')]")
      expect(page).to have_content(review3.name)
      expect(page).to have_content(review3.title)
      expect(page).to have_content(review3.rating.to_s)
      expect(page).to have_content(review3.content)
      expect(page).to have_xpath("//img[contains(@src,'#{review3.picture}')]")
      expect(page).to have_content(review3.name)

      visit "/shelters/#{shelter2.id}"
      expect(page).to have_content(review2.title)
      # expect(page).to have_content(review2.rating.to_s)
      expect(page).to have_content(review2.content)
      expect(page).to have_xpath("//img[contains(@src,'#{review2.picture}')]")
      expect(page).to have_content(review4.name)
      expect(page).to have_content(review4.title)
      expect(page).to have_content(review4.rating.to_s)
      expect(page).to have_content(review4.content)
      expect(page).to have_xpath("//img[contains(@src,'#{review4.picture}')]")
      expect(page).to have_content(review4.name)
    end
  end
end
ß
# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
# - title
# - rating
# - content
# - the name of a user that exists in the database
# I also see a field where I can enter an optional image (web address)
# When the form is submitted, I should return to that shelter's show page
# and I can see my new review

describe 'As a visitor' do
  describe "When I visit a shelter's show page" do
    it 'should see a link to add a new review' do
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
      visit "/shelters/#{shelter1.id}"

      expect(page).to have_link('New Review')

      visit "/shelters/#{shelter1.id}"
      click_link 'New Review'

      expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/new")
    end
  end
end
