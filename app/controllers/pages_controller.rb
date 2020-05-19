class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:workshop, :panel]
  before_action :authenticate_admin!, only: :panel
  layout 'scaffolds', only: :panel
  
  def home
    @workshops = Workshop.order(created_at: :desc)
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
    @contact = Contact.new
    if user_signed_in?
      @contact.name = current_user.name
      @contact.email = current_user.email
    end
    if (publication = params[:publication]).present?
      @contact.message = "Consulta por Publicación: #{publication}.\r\n"
    end
  end

  def panel
  end
end
