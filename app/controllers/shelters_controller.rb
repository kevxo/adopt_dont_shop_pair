class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
    shelter = Shelter.new({
                            name: params[:shelter][:name],
                            address: params[:shelter][:address],
                            city: params[:shelter][:city],
                            state: params[:shelter][:state],
                            zip: params[:shelter][:zip]
                          })

    shelter.save

    redirect_to '/shelters'
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = Review.where(shelter_id: @shelter.id)
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({
                     name: params[:shelter][:name],
                     address: params[:shelter][:address],
                     city: params[:shelter][:city],
                     state: params[:shelter][:state],
                     zip: params[:shelter][:zip]
                   })

    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    @shelter = Shelter.find(params[:id])
    if !@shelter.cant_delete?
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    else
      flash[:notice] = "Shelter can't be deleted: Pet status is pending/approved"
      redirect_to '/shelters'
    end
  end

  def pet_index
    shelter_id = params[:id]
    @pets = Pet.where("shelter_id  = #{shelter_id}")
  end
end
