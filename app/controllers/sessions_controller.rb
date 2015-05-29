class SessionsController < ApplicationController

  # XXX Ensure active session.
  before_action :ensure_session, except: [:new, :create]

  def show
    @session = Session.find_or_initialize_by(id: params[:id])

    # XXX Secure reference to objects.
    handle_unauthorized! unless current_session.id == @session.id
  end

  def new
    @user = User.new
  end

  def create
    sign_out
    user = User.find_by(email: user_params[:email])

    if sign_in!(user, user_params[:password], remember_me: truthy?(user_params[:remember_me]))
      redirect_to user_path(user)
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :remember_me)
  end

  def truthy?(value)
    %w[1 true].include? value
  end

end
