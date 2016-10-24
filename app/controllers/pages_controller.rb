class PagesController < ApplicationController
  before_action :authenticate_user!, only: :workshop
  
  def home
  end
  
  def welcome
  end
  
  def workshops
    @workshops = Workshop.order(created_at: :desc)
  end
  
  def workshop
    @workshops = [Workshop.friendly.find(params[:workshop_id])]
    render :workshops
  end
  
  def bouquets
  end
  
  def face_workshops
  end
  
  def publications
  end
  
  def contact
  end
end
