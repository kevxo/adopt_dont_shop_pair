class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:application_id])
    @pet_search_result = Pet.pet_search(params[:pet_search])
  end

end
