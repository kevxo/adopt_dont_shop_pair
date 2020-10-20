class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:application_id])
  end

  def update
    application = Application.find(params[:application_id])
    application_pets = PetApplication.where(application_id: params[:application_id])
    pet_application = PetApplication.where(application_id: params[:application_id], pet_id: params[:pet_approval])

    if params[:commit] == "Approve Pet"
      pet_application.update(application_status: "Approved")
    elsif params[:commit] == "Reject Pet"
      pet_application.update(application_status: "Rejected")
    end

    if application_pets.all_approved?(params[:application_id]) && !application_pets.any_pending?(params[:application_id])
      application.update(application_status: "Approved")
      application.adopt_pets
    elsif !application_pets.all_approved?(params[:application_id]) && !application_pets.any_pending?(params[:application_id])
      application.update(application_status: "Rejected")
    end

    redirect_to "/admin/applications/#{params[:application_id]}"
  end

end
