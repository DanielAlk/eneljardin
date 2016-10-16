class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :update, :destroy]
  respond_to :json

  # GET /comments.json
  def index
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/1.json
  def show
    render json: @comment
  end

  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1.json
  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:title, :comment, :commentable_id, :commentable_type, :user_id, :role)
    end
end
