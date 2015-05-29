module SessionsHelper

  def sign_in!(user, password)
    valid_password = user.try(:authenticate, password)

    if user && valid_password
      # XXX Session management with signed cookie. Session expires in 10 seconds.
      Session.find_or_create_by(user: user).touch
      # cookies.signed[:session] = { value: user.session.id, expires: 1.day.from_now }
      cookies.signed[:session] = { value: user.session.id, expires: 5.seconds.from_now }

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

end
