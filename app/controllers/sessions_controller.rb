class SessionsController < ApplicationController
  def new; end

  def create
    if @user&.authenticate params[:session][:password]
      check_activated
    else
      flash.now[:danger] = t ".invalid_email_password"
      redirect_to root_url
    end
  end

  def destroy
    log_out if logged_in?

    redirect_to root_url
  end

  def check_activated
    if user.activated?
      log_in user
      params[:session][:remember] == "1" ? remember(user) : forget(user)
      redirect_to user
    else
      flash[:warning] = t ".account_not_actived"
      redirect_to root_url
    end
  end

  private
  def remember_user user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_back_or user
  end
end
