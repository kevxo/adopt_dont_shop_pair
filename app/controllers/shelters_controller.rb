class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
    shelter = Shelter.new({
                            name: params[:name],
                            address: params[:address],
                            city: params[:city],
                            state: params[:state],
                            zip: params[:zip]
                          })
    if shelter.name != ""
      shelter.save
      redirect_to '/shelters'
    else
      flash[:notice] = "Shelter not created: Please provide a shelter name."
      redirect_to '/shelters/new'
    end

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
                     name: params[:name],
                     address: params[:address],
                     city: params[:city],
                     state: params[:state],
                     zip: params[:zip]
                   })

    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    @shelter = Shelter.find(params[:id])
    if @shelter.deletable?
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
