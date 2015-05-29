module SessionsHelper

  def sign_in!(user, password, remember_me: false)
    valid_password = user.try(:authenticate, password)

    if user && valid_password
      # XXX Session management with signed cookie. Session expires in 10 seconds.
      Session.find_or_create_by(user: user).touch

      if remember_me
        cookies.signed[:session] = { value: user.session.id, expires: 1.day.from_now }
      else
        cookies.signed[:session] = { value: user.session.id, expires: 5.seconds.from_now }
      end

      user
    else
      flash.alert = 'Invalid password' if user
      flash.alert = 'Invalid email' unless user
      redirect_to new_session_path

      nil
    end
  end

  def sign_out
    cookies.signed[:session] = nil
  end

  def ensure_session
    redirect_to new_session_path unless current_session
  end

end
