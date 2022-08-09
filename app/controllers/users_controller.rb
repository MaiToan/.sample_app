class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".alert_success"
      redirect_to @user
    else
      render :new
      flash.now[:danger] = t ".alert_err_create"
    end
  end
  private

  def user_params
    params.require(:user).permit(User::USER_ATTR)
  end
end
