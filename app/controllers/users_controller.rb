class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = Review.where(user_id: @user.id)
  end

  def new
  end

  def create
    user = User.create(user_params)
    redirect_to "/users/#{user.id}"
  end

  private
  def user_params
    params.permit(:name, :street_address, :city, :state, :zip)
  end

end
