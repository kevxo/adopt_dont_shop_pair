class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
    @id = params[:id]
  end

  def create
    pet = Pet.new({
                    image: params[:pet][:image],
                    name: params[:pet][:name],
                    description: params[:pet][:description],
                    approximate_age: params[:pet][:approximate_age],
                    sex: params[:pet][:sex]
                  })

    pet.save

    redirect_to "/shelters/#{params[:id]}/pets"
  end

  def show
    @pets = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update({
                 image: params[:pet][:image],
                 name: params[:pet][:name],
                 description: params[:pet][:description],
                 approximate_age: params[:pet][:approximate_age],
                 sex: params[:pet][:sex],
                 adoptable: params[:pet][:adoptable]
               })

    pet.save
    redirect_to "/pets/#{pet.id}"
  end
end