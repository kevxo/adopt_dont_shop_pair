class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
    @id = params[:id]
  end

  def create
    pet = Pet.new({
                    img: params[:img],
                    name: params[:name],
                    description: params[:description],
                    approximate_age: params[:approximate_age],
                    sex: params[:sex],
                    adoptable: params[:adoptable],
                    shelter_id: params[:id]
                  })

    pet.save
    redirect_to "/shelters/#{params[:id]}/pets"
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update({
                 img: params[:img],
                 name: params[:name],
                 description: params[:description],
                 approximate_age: params[:approximate_age],
                 sex: params[:sex],
                 adoptable: params[:adoptable]
               })

    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    shelter = Shelter.find(pet.shelter_id)
    if pet.deletable?
      Pet.destroy(params[:id])
      redirect_to '/pets'
    else
      flash[:notice] = "Pet can't be deleted: Pet has an approved application."
      redirect_to "/shelters/#{shelter.id}/pets"
    end
  end
end
