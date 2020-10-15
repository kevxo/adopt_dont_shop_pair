class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:id]
  end

  def create
    user_id = User.find_by(name: params[:review][:user_name])

    # binding.pry
    if user_id
      review = Review.new({
        user_name: params[:review][:user_name],
        title: params[:review][:title],
        picture: params[:review][:picture],
        content: params[:review][:content],
        rating: params[:review][:rating],
        user_id: user_id.id,
        shelter_id: params[:id]
      })

      if review.save
        review.save
        redirect_to "/shelters/#{params[:id]}/reviews/new"
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
    review.update!(review_params)
    redirect_to "/shelters/#{params[:shelter_id]}"
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
