class ClassroomController < ApplicationController
	before_action :authenticate_user!, only: :video
	
  def videos
    @workshops = Workshop.all
  end

  def video
    @movie = Movie.friendly.find(params[:movie_id])
  	@other_movies = Movie.where.not(id: @movie.id)
    @comments = @movie.comments.order(created_at: :desc).paginate(page: 1, per_page: 4)
  end

  def notes
    @notes = Note.all
  end
end
