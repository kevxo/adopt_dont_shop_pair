class ApplicationsController < ApplicationController

  def new

  end

  def show
    @application = Application.find(params[:application_id])
  end
end
