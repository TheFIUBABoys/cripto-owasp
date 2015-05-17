module ErrorHelper

  def handle_unauthorized!
    redirect_to unauthorized_path
  end

end
