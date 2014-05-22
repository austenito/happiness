class RegistrationsController < Devise::RegistrationsController
  def create
    super
    # hit the api to create the user
  end
end
