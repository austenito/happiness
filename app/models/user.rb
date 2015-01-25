class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :service_user

  before_create :create_service_user

  def create_survey
    service_user.create_survey
  end

  def create_random_survey
    # find all of the questions based on ids
    # add them to the survey (add more than one question)
    # do the thing
    service_user.create_random_survey
  end

  def service_user
    @service_user ||= Poptart::User.for_id(service_user_id) end

  def surveys
    service_user.surveys
  end

  def time_zone
    'Eastern Time (US & Canada)'
  end

  private

  def create_service_user
    @service_user = Poptart::User.create
    self.token = @service_user.token
    self.service_user_id = @service_user.service_user_id
  end
end
