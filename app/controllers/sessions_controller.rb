class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      redirect_to root_url
    else
      render "sessions/new"
    end
  end

  def destroy
    redirect_to root_url unless logged_in?
    log_out
    redirect_to root_url
  end

end
