require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
    it { should have_many :reviews }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'instance methods' do
    it 'should count the pets in a shelter' do
      shelter_1 = Shelter.create!(name: 'Colorado Cares', address: '867 magnolia st',
                                  city: 'Lakewood', state: 'CO', zip: '80022')

      pet1 = shelter_1.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg',
                                    name: 'Tony',
                                    approximate_age: '2',
                                    sex: 'male',
                                    description: 'Tony is a wild cracker at times, but is able to calm down and cuddle when needed.')
      pet2 = shelter_1.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg',
                                    name: 'Isabell',
                                    approximate_age: '5',
                                    sex: 'female',
                                    description: "Isabell is my favorite and I don't want her to go...but then again, I do!")

      expect(shelter_1.pet_count).to eq(2)
    end

    it 'should average the ratings for a shelter' do
      shelter_1 = Shelter.create!(name: 'Colorado Cares', address: '867 magnolia st',
                                  city: 'Lakewood', state: 'CO', zip: '80022')
      user_1 = User.create!(name: 'Holly Baker',
                            street_address: '4443 fountain ave',
                            city: 'Lakewood',
                            state: 'CO',
                            zip: '80009')
      user_2 = User.create!(name: 'Jeff Daniels',
                            street_address: '455 west dr',
                            city: 'Denver',
                            state: 'Colorado',
                            zip: '87709')
      review_1 = shelter_1.reviews.new(title: 'Colorado Cares is the best', rating: 5,
                                       content: 'I absolutely love this shelter. I have found the best friend a woman could have!',
                                       user_name: 'Holly', picture: 'https://tilasto.info/arkkitehti/wp-content/uploads/2019/02/kirkkokivi1.jpg')
      review_1.user_id = user_1.id
      review_1.save!
      review_2 = shelter_1.reviews.new(title: 'Ehhhhh', rating: 1,
                                       content: 'All I can say is nope', user_name: 'Jeff', picture: 'https://cdn.hpm.io/wp-content/uploads/2019/06/25143552/Dogs-1000x750.jpg')
      review_2.user_id = user_2.id
      review_2.save!
      expect(shelter_1.average_rating).to eq(3)
    end

    it 'number of applications.' do
      shelter_1 = Shelter.create!(name: 'Colorado Cares', address: '867 magnolia st',
                                  city: 'Lakewood', state: 'CO', zip: '80022')

      pet1 = shelter_1.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg',
                                    name: 'Tony',
                                    approximate_age: '2',
                                    sex: 'male',
                                    description: 'Tony is a wild cracker at times, but is able to calm down and cuddle when needed.')
      pet2 = shelter_1.pets.create!(img: 'https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg',
                                    name: 'Isabell',
                                    approximate_age: '5',
                                    sex: 'female',
                                    description: "Isabell is my favorite and I don't want her to go...but then again, I do!")
      user_1 = User.create!(name: 'Holly Baker',
                            street_address: '4443 fountain ave',
                            city: 'Lakewood',
                            state: 'CO',
                            zip: '80009')
      user_2 = User.create!(name: 'Jeff Daniels',
                            street_address: '455 west dr',
                            city: 'Denver',
                            state: 'Colorado',
                            zip: '87709')

      review_1 = shelter_1.reviews.new(title: 'Colorado Cares is the best', rating: 5,
                                       content: 'I absolutely love this shelter. I have found the best friend a woman could have!',
                                       user_name: 'Holly', picture: 'https://tilasto.info/arkkitehti/wp-content/uploads/2019/02/kirkkokivi1.jpg')
      review_1.user_id = user_1.id
      review_1.save!

      review_2 = shelter_1.reviews.new(title: 'Ehhhhh', rating: 1,
                                       content: 'All I can say is nope', user_name: 'Jeff', picture: 'https://cdn.hpm.io/wp-content/uploads/2019/06/25143552/Dogs-1000x750.jpg')
      review_2.user_id = user_2.id
      review_2.save!

      application_1 = Application.create!(user_name: user_1.name, address: "#{user_1.street_address}, #{user_1.city}, #{user_1.state} #{user_1.zip}",
                                          description: 'I am an experienced pet owner for 5 years and I just love this pet!',
                                          pet_names: pet1.name.to_s, user_id: user_1.id)
      application_2 = Application.create!(user_name: user_2.name, address: "#{user_2.street_address}, #{user_2.city}, #{user_2.state} #{user_2.zip}",
                                          description: 'I would be a loving owner for any of these pets. Enough said.',
                                          pet_names: pet2.name.to_s, user_id: user_2.id)

      PetApplication.create!(pet_id: pet1.id, application_id: application_1.id)
      PetApplication.create!(pet_id: pet2.id, application_id: application_2.id)

      expect(shelter_1.number_of_applications).to eq(2)
    end
  end
end
