class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :upvote]
  before_filter :authenticate_user!
  
  respond_to :html
  
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @comments = @user.comments
    else
      @comments = Comment.all 
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end




  def create
    @song = Song.find(params[:song_id])
    @comment = @song.comments.new(comment_params)
     @comment.user = current_user
   respond_to do |format|
      if @comment.save
        format.html { redirect_to @song, notice: '投稿に成功しました' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'コメントを削除しました' }
      format.json { head :no_content }
    end
  end
  
  def upvote
    @comment.upvote_by current_user
    redirect_to :back
  end
  


  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:song_id, :body, :user_id, :image)
    end
    
end
