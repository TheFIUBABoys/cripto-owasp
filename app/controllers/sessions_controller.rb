class SessionsController < ApplicationController

  def show
    @session = Session.find_by(id: params[:id])

    # XXX Secure reference to objects.
    handle_unauthorized! unless @session && current_session.id == @session.id
  end

  def new
    @user = User.new
  end

  def create
    sign_out
    user = User.find_by(email: user_params[:email])
    redirect_to user_path(user) if sign_in!(user, user_params[:password])
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
