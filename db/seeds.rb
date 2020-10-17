# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter_1 = Shelter.create!(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")
shelter_2 = Shelter.create!(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
shelter_3 = Shelter.create!(name: "Mile High Adoptive Services", address: "500 w first st", city: "Centennial", state: "CO", zip: "80022")
pet_1 = shelter_1.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                  name: "Tony",
                  approximate_age: "2",
                  sex: "male",
                  description: "Tony is a wild cracker at times, but is able to calm down and cuddle when needed.")
pet_2 = shelter_2.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg",
                              name: "Isabell",
                              approximate_age: "5",
                              sex: "female",
                              description: "Isabell is my favorite and I don't want her to go...but then again, I do!")
pet_3 = shelter_3.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/akita-dogs-and-puppies/akita-dogs-puppies-2.jpg",
                              name: "Snowball",
                              approximate_age: "1",
                              sex: "female",
                              description: "Just the cutest.")
pet_4 = shelter_2.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/golden-retriever-dogs-and-puppies/golden-retriever-dogs-puppies-10.jpg",
                              name: "Watson",
                              approximate_age: "3",
                              sex: "male",
                              description: "He may look dumb, and he is.")
pet_5 = shelter_1.pets.create!(img: "https://dogtime.com/assets/uploads/gallery/belgain-malinois-dog-breed-pictures/8-senior.jpg",
                              name: "Uma",
                              approximate_age: "4",
                              sex: "female",
                              description: "Don't let her beauty fool ya, she's a stone-cold killer.")

user_1 = User.create!(name: 'Bob Woodword',
                    street_address: '1234 Test Dr',
                    city: 'Denver',
                    state: 'Colorado',
                    zip: '12345')

user_2  = User.create!(name: 'Jeff Daniels',
                    street_address: '455 west dr',
                    city: 'Denver',
                    state: 'Colorado',
                    zip: '87709')

user_3 = User.create!(name: 'Holly Baker',
                    street_address: '4443 fountain ave',
                    city: 'Lakewood',
                    state: 'CO',
                    zip: '80009')

review_1 = shelter_2.reviews.new(title: "Colorado Cares is the best", rating: 5,
          content: "I absolutely love this shelter. I have found the best friends a man could have!",
          user_name: user_1.name)
review_1.user_id = user_1.id
review_1.save!

review_2 = shelter_1.reviews.new(title: "Rocky Mountain High, more like Rocky Mountain bye", rating: 1,
                                content: "All I can say is nope", user_name: user_1.name)
review_2.user_id = user_1.id
review_2.save!

review_3 = shelter_2.reviews.new(title: "Colorado Cares, not my style", rating: 3,
          content: "Too many dalmations!", user_name: user_2.name)
review_3.user_id = user_2.id
review_3.save!

application_1 = Application.create!(user_name: user_1.name, address: "#{user_1.street_address}, #{user_1.city}, #{user_1.state} #{user_1.zip}",
                                  description: "I am an experienced pet owner for 5 years and I just love this pet!",
                                  pet_names: "#{pet_1.name}, #{pet_2.name}", user_id: user_1.id)

application_2 = Application.create!(user_name: user_2.name, address: "#{user_2.street_address}, #{user_2.city}, #{user_2.state} #{user_2.zip}",
                                  description: "I would be a loving owner for any of these pets. Enough said.",
                                  pet_names: "#{pet_2.name}, #{pet_4.name}", user_id: user_2.id)

PetApplication.create!(pet_id: pet_1.id, application_id: application_1.id)
PetApplication.create!(pet_id: pet_2.id, application_id: application_1.id)
PetApplication.create!(pet_id: pet_2.id, application_id: application_2.id)
PetApplication.create!(pet_id: pet_4.id, application_id: application_2.id)
PetApplication.create!(pet_id: pet_5.id, application_id: application_2.id)
