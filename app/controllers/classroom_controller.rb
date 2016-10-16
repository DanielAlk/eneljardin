class ClassroomController < ApplicationController
	before_action :authenticate_user!, only: :video
	
  def videos
  	@movies = Movie.all
  end

  def video
  	@movies = Movie.all
  	@movie = Movie.find(params[:movie_id])
  end

  def notes
  end
end
