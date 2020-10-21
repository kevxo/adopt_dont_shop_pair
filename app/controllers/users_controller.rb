class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = Review.where(user_id: @user.id)
  end

  def new
  end

  def create
    user = User.new(user_params)
    if user.name != ""
      user.save
      redirect_to "/users/#{user.id}"
    else
      flash[:notice] = "User not created: Please include a username."
      redirect_to "/users/new"
    end
  end

  private
  def user_params
    params.permit(:name, :street_address, :city, :state, :zip)
  end

end
