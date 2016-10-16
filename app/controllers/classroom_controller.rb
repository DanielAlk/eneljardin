class ClassroomController < ApplicationController
	before_action :authenticate_user!, only: :video
	
  def videos
  	@movies = Movie.all
  end

  def video
  	@movies = Movie.all
  	@movie = Movie.find(params[:movie_id])
    @comments = @movie.comments.recent.limit(4).all
  end

  def video_comments
    movie = Movie.find(params[:movie_id])
    @comments = Comment.where(commentable: movie).paginate(page: params[:page], per_page: 4).order(created_at: :asc)
    render json: @comments
  end

  def notes
  end
end
