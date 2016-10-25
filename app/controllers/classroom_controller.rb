class ClassroomController < ApplicationController
	before_action :authenticate_user!
	
  def videos
    if current_user.admin?
      @workshops = Workshop.all
    else
      @workshops = current_user.workshops
      unless @workshops.present?
        if current_user.payments.in_process.present?
          redirect_to workshops_page_url, notice: 'Estamos procesando tu pago.'
        else
          redirect_to workshops_page_url, notice: 'Todavía no compraste ningún taller.'
        end
      end
    end
  end

  def video
    @movie = Movie.friendly.find(params[:movie_id])
    if current_user.user?
      if @movie.workshop.is_owned_by? current_user
        if @movie.workshop.status_for(current_user) == :in_process
          redirect_to workshop_page_url(@movie.workshop), notice: 'Estamos procesando el pago por este taller.'
        end
      else
        raise ActionController::RoutingError.new("No route matches [GET] \"#{request.path}\"")
      end
    end
    @other_movies = Movie.where.not(id: @movie.id)
    @comments = @movie.comments.order(created_at: :desc).paginate(page: 1, per_page: 12)
  end

  def notes
    if current_user.admin?
      @notes = Note.all
    else
      @notes = current_user.notes
    end
  end
end
