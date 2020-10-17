class ApplicationsController < ApplicationController
  def new
  end

  def create
    user_id = User.find_by name: params[:user_name]
    application = Application.new({user_name: params[:user_name],
                                  address: params[:address],
                                  description: params[:description],
                                  pet_names: params[:pet_names],
                                  application_status: params[:application_status],
                                  user_id: user_id.id})

    application.save
    application.pet_names_ids.each do |id|
      PetApplication.create!(pet_id: id, application_id: application.id)
    end
    redirect_to "/applications/#{application.id}"
  end

  def show
    @application = Application.find(params[:application_id])
  end
end
