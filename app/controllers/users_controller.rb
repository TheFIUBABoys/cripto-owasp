class UsersController < ApplicationController

  # XXX Ensure active session.
  before_action :ensure_session, except: [:new, :create]

  def show
    @user = User.find_by(id: params[:id])

    handle_unauthorized! unless @user && current_user.id == @user.id
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.errors.any?
      render :new
    else
      redirect_to user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
