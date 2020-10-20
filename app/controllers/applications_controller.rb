class ApplicationsController < ApplicationController
  def new
  end

  def create
    user_id = User.find_by name: params[:user_name]
    if user_id
      application = Application.new({user_name: params[:user_name], user_id: user_id.id})
      application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Application not created: User couldn't be found."
      redirect_to '/applications/new'
    end
  end

  def show
    @application = Application.find(params[:application_id])
    if params[:pet_search] != "" && Pet.pet_search(params[:pet_search]) != []
      @pet_search_result = Pet.pet_search(params[:pet_search])
    elsif params[:pet_search]
      flash[:pet_notice] = "Sorry, that pet name does not exist in our records."
    end
  end

  def update
    application = Application.find(params[:application_id])
    if params[:commit] == "Submit Application" && params[:description] != ""
      application.update(description: params[:description], application_status: "Pending")
    elsif params[:commit] == "Submit Application"
      flash[:description_notice] = "Application not submitted: Please explain why you would be a good pet owner."
    elsif params[:pet_name] && application.unique_pet?(params[:pet_name])
      application.update(pet_names: application.add_pet_name(params[:pet_name]))
      PetApplication.create(pet_id: params[:pet_id], application_id: params[:application_id])
    end
    redirect_to "/applications/#{params[:application_id]}"
  end
end
