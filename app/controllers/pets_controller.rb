class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
    @id = params[:id]
  end

  def create
    pet = Pet.new({
                    img: params[:pet][:img],
                    name: params[:pet][:name],
                    description: params[:pet][:description],
                    approximate_age: params[:pet][:approximate_age],
                    sex: params[:pet][:sex],
                    adoptable: params[:pet][:adoptable],
                    shelter_id: params[:id]
                  })
    if pet.name != ""
      pet.save
      redirect_to "/shelters/#{params[:id]}/pets"
    else
      flash[:notice] = "Pet not created: Please include a pet name."
      redirect_to "/shelters/#{params[:id]}/pets/new"
    end

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
                 img: params[:pet][:img],
                 name: params[:pet][:name],
                 description: params[:pet][:description],
                 approximate_age: params[:pet][:approximate_age],
                 sex: params[:pet][:sex],
                 adoptable: params[:pet][:adoptable]
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
