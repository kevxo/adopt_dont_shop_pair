class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:application_id])
    @pet_search_result = Pet.pet_search(params[:pet_search])
  end

  def update
    application = Application.find(params[:application_id])
    if params[:pet_name]
      application.update(pet_names: application.pet_names.concat(", #{params[:pet_name]}"))
      PetApplication.create(pet_id: params[:pet_id], application_id: params[:application_id])
    end
    if params[:commit] == "Submit Application" && params[:description]
      application.update(description: params[:description], application_status: "Pending")
    elsif params[:commit] == "Submit Application"
      flash[:notice] = "Application not submitted: Please explain why you would be a good pet owner."
      # redirect_to "/applications/#{params[:application_id]}"
    end
    redirect_to "/applications/#{params[:application_id]}"
  end

end
