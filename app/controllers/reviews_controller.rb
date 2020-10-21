class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:id]
  end

  def create
    user_id = User.find_by(name: params[:user_name])

    if user_id
      review = Review.new({
        user_name: params[:user_name],
        title: params[:title],
        picture: params[:picture],
        content: params[:content],
        rating: params[:rating],
        user_id: user_id.id,
        shelter_id: params[:id]
      })
      if review.save
        review.save
        redirect_to "/shelters/#{params[:id]}"
      else
        flash[:notice] = 'Review not created: Need title, content, and rating.'
        redirect_to "/shelters/#{params[:id]}/reviews/new"
      end
    else
      flash[:notice] = "Review not created: User couldn't be found."
      redirect_to "/shelters/#{params[:id]}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    user = User.find_by(name: params[:user_name])
    updated_review = review.update(review_params)
    if user && updated_review
      redirect_to "/shelters/#{params[:shelter_id]}"
    elsif user
      flash[:notice] = "Review not updated: Need title, content, and rating."
      redirect_to "/shelters/#{params[:shelter_id]}/reviews/#{params[:review_id]}/edit"
    else
      flash[:notice] = "Review not updated: User doesn't exist in database."
      redirect_to "/shelters/#{params[:shelter_id]}/reviews/#{params[:review_id]}/edit"
    end
  end

  def destroy
    Review.find(params[:review_id]).destroy
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :picture, :user_name)
  end
end
