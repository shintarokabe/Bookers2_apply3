class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:update, :edit]}

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def followings
    set_user
    @followings = @user.following_user

  end

  def followers
    set_user
    @followers = @user.follower_user
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
