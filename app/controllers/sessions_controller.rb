class SessionsController < Devise::SessionsController
  def create
    super
    # hit the api to create the user
  end
end
