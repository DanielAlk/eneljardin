class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_registrations, only: [:edit], if: -> { current_user === @user }
  layout 'scaffolds'

  # GET /users
  # GET /users.json
  def index
    @users = User.order(role: :desc, name: :asc).where.not(email: current_user.email).paginate(page: params[:page], per_page: 12)
    unless current_user.is_webmaster?
      @users = @users.where(role: 0)
    end
    if params[:search]
      @users = @users.where('users.name LIKE :string OR users.email LIKE :string', string: '%' + params[:search] + '%')
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @available_workshops = Workshop.where.not(id: @user.workshops.map{|w| w.id})
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :avatar, :role, :email, :use_default_avatar, :renew_expiration_for, :expirate_for, :assign_workshop)
    end

    def redirect_to_registrations
      redirect_to edit_user_registration_path
    end
end
