class PagesController < ApplicationController
  def home
  end
  
  def welcome
  end
  
  def workshops
    @workshops = Workshop.order(created_at: :desc)
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
