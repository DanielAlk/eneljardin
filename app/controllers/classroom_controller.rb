class ClassroomController < ApplicationController
  def videos
  	@movies = Movie.all
  end

  def video
  end

  def notes
  end
end
