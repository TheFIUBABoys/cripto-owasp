module SessionsHelper

  def sign_in!(user, password)
    valid_password = user.try(:authenticate, password)

    if user && valid_password
      # XXX Session management with signed cookie.
      Session.find_or_create_by(user: user).touch
      cookies.permanent.signed[:session] = user.session.id

      user
    else
      flash.alert = 'Invalid password' if user
      flash.alert = 'Invalid email' unless user
      redirect_to new_session_path

      nil
    end
  end

  def sign_out
    cookies.permanent.signed[:session] = nil
  end

end
