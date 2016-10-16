class ClassroomController < ApplicationController
	before_action :authenticate_user!, only: :video
	
  def videos
  	@movies = Movie.all
  end

  def video
  	@movies = Movie.all
  	@movie = Movie.find(params[:movie_id])
    @comments = @movie.comments.order(created_at: :desc).paginate(page: 1, per_page: 4)
  end

  def notes
  end
end
