class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    super.tap do |current_user|
      Poptart.authorize(service_user_id: current_user.service_user_id,
                        user_token: current_user.token)
    end
  end
end
