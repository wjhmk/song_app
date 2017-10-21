class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @song = current_user.songs.build(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def like
      @user = User.find(params[:id])
      @songs = @user.votes.up.for_type(Song).votables
                                      #対応関係一致↑、songはvoteされるからvotable
  end
  
  def good
      @user = User.find(params[:id])
      @comments = @user.votes.up.for_type(Comment).votables
                                      #対応関係一致↑、commentはvoteされるからcomment
  end
 
 
end
