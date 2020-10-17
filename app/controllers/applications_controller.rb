class ApplicationsController < ApplicationController
  def new
  end

  def create
    user_id = User.find_by name: params[:user_name]
    application = Application.new({user_name: params[:user_name], user_id: user_id.id})
    application.save
    redirect_to "/applications/#{application.id}"
  end

  def show
    @application = Application.find(params[:application_id])
    @pet_search_result = Pet.pet_search(params[:pet_search])
  end

  def update
    application = Application.find(params[:application_id])
    application.update(pet_names: application.pet_names.concat(", #{params[:pet_name]}"))
    PetApplication.create(pet_id: params[:pet_id], application_id: params[:application_id])
    redirect_to "/applications/#{params[:application_id]}"
  end
end
