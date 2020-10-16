require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :reviews }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'instance methods' do
    it '.average_rating' do
      shelter_1 = Shelter.create!(name: 'Colorado Cares', address: '867 magnolia st',
                                  city: 'Lakewood', state: 'CO', zip: '80022')

      user = User.create!(name: 'Bob Woodword',
                          street_address: '1234 Test Dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '12345')
      review_1 = shelter_1.reviews.new(title: 'Colorado Cares is the best', rating: 5,
                                       content: 'I absolutely love this shelter. I have found the best friends a man could have!',
                                       user_name: user.name)
      review_1.user_id = user.id
      review_1.save!

      review_2 = shelter_1.reviews.new(title: 'Mile High, more like Mile bye', rating: 1,
                                       content: 'All I can say is nope', user_name: user.name)
      review_2.user_id = user.id
      review_2.save!

      review_3 = shelter_1.reviews.new(title: 'Mile High, not my style', rating: 3,
                                       content: 'Too many dalmations!', user_name: user.name)
      review_3.user_id = user.id
      review_3.save!

      expect(user.average_rating).to eq(3)
    end

    it '.best_rating_review' do
      shelter_1 = Shelter.create!(name: 'Colorado Cares', address: '867 magnolia st',
                                  city: 'Lakewood', state: 'CO', zip: '80022')

      user = User.create!(name: 'Bob Woodword',
                          street_address: '1234 Test Dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '12345')
      review_1 = shelter_1.reviews.new(title: 'Colorado Cares is the best', rating: 5,
                                       content: 'I absolutely love this shelter. I have found the best friends a man could have!',
                                       user_name: user.name)
      review_1.user_id = user.id
      review_1.save!

      review_2 = shelter_1.reviews.new(title: 'Mile High, more like Mile bye', rating: 1,
                                       content: 'All I can say is nope', user_name: user.name)
      review_2.user_id = user.id
      review_2.save!

      review_3 = shelter_1.reviews.new(title: 'Mile High, not my style', rating: 3,
                                       content: 'Too many dalmations!', user_name: user.name)
      review_3.user_id = user.id
      review_3.save!

      expect(user.best_rating_review).to eq(review_1)
    end

    it '.worst_rating_review' do
      shelter_1 = Shelter.create!(name: 'Colorado Cares', address: '867 magnolia st',
                                  city: 'Lakewood', state: 'CO', zip: '80022')

      user = User.create!(name: 'Bob Woodword',
                          street_address: '1234 Test Dr',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '12345')
      review_1 = shelter_1.reviews.new(title: 'Colorado Cares is the best', rating: 5,
                                       content: 'I absolutely love this shelter. I have found the best friends a man could have!',
                                       user_name: user.name)
      review_1.user_id = user.id
      review_1.save!

      review_2 = shelter_1.reviews.new(title: 'Mile High, more like Mile bye', rating: 1,
                                       content: 'All I can say is nope', user_name: user.name)
      review_2.user_id = user.id
      review_2.save!

      review_3 = shelter_1.reviews.new(title: 'Mile High, not my style', rating: 3,
                                       content: 'Too many dalmations!', user_name: user.name)
      review_3.user_id = user.id
      review_3.save!

      expect(user.worst_rating_review).to eq(review_2)
    end
  end
end
