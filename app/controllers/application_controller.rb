class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  	def authenticate_admin!
  		raise ActionController::RoutingError.new("No route matches [GET] \"#{request.path}\"") unless user_signed_in? && current_user.admin?
  	end
end
