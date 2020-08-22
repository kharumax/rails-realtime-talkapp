class UsersController < ApplicationController
  before_action :set_user,only: [:show,:edit,:destroy]

  def home

  end

  def index
    @users = User.all
  end

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      log_in(@user)
      redirect_to root_url
    else
      render "users/new"
    end
  end

  def edit

  end

  def update
    if @user.update_attributes(update_params)
      redirect_to root_url
    else
      render "users/edit"
    end
  end

  def destroy
  end

  private

  def sign_up_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def update_params
    params.require(:user).permit(:name)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

end
