class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :service_user

  before_create :create_service_user

  def create_survey
    service_user.create_survey
  end

  def create_random_survey
    service_user.create_random_survey
  end

  def survey_for_id(survey_id)
    Survey.new(service_user.survey_for_id(survey_id))
  end

  def service_user
    @service_user ||= Poptart::User.for_id(service_user_id)
  end

  def surveys
    service_user.surveys
  end

  private

  def create_service_user
    @service_user = Poptart::User.create
    self.token = @service_user.token
    self.service_user_id = @service_user.service_user_id
  end
end
