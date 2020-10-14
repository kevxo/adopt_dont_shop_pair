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

  describe "when I visit shelter show page" do
    it "I can edit each review listed" do
      shelter_1 = Shelter.create!(name: "Colorado Cares", address: "867 magnolia st",
                                  city: "Lakewood", state: "CO", zip: "80022")

      user_1 = User.create!(name: 'Holly Baker',
                          street_address: '4443 fountain ave',
                          city: 'Lakewood',
                          state: 'CO',
                          zip: '80009')
      user_2  = User.create!(name: 'Jeff Daniels',
                          street_address: '455 west dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '87709')

      review_1 = shelter_1.reviews.new(title: "Colorado Cares is the best", rating: 5,
                content: "I absolutely love this shelter. I have found the best friend a woman could have!",
                user_name: "Holly")
      review_1.user_id = user_1.id
      review_1.save!

      review_2 = shelter_1.reviews.new(title: "Ehhhhh", rating: 1,
                content: "All I can say is nope", user_name: "Jeff")
      review_2.user_id = user_2.id
      review_2.save!

      # visit "/shelters/#{shelter_1.id}"
      #
      # within ("#review-#{review_1.id}") do
      #   expect(page).to have_link("edit review")
      #   click_on("edit review")
      # end

      visit "/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")
      expect(find_field(:title).value).to eq(review_1.title)
      expect(find_field(:rating).value).to eq(review_1.rating)
      expect(find_field(:content).value).to eq(review_1.content)
      expect(find_field(:image).value).to eq(review_1.image)
      expect(find_field(:user_name).value).to eq(review_1.user_name)
      expect(find_field(:title).value).to_not eq(review_2.title)
      expect(find_field(:rating).value).to_not eq(review_2.rating)
      expect(find_field(:content).value).to_not eq(review_2.content)
      expect(find_field(:image).value).to_not eq(review_2.image)
      expect(find_field(:user_name).value).to_not eq(review_2.user_name)

      new_rating = 4
      new_name = "Harold"

      fill_in :rating, with: new_rating
      fill_in :user_name, with: new_name

      click_on("update review")

      expect(current_path).to eq("/shelters/#{review_1.id}")
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(new_rating)
      expect(page).to have_content(new_name)
      expect(page).to have_content(review_1.content)
      expect(page).to have_content(review_1.image)
      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_2.rating)
      expect(page).to have_content(review_2.content)
      expect(page).to have_content(review_2.user_name)
      expect(page).to have_content(review_2.image)

    end
  end

end
