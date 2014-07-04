class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :service_user

  before_create :generate_external_user_id
  after_create :create_service_user

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
    @service_user ||= Poptart::User.for_id(external_user_id)
  end

  private

  def generate_external_user_id
    unless self.external_user_id
      self.external_user_id = Digest::SHA512.hexdigest(Time.now.to_s + "nyan")
    end
  end

  def create_service_user
    @service_user = Poptart::User.create(external_user_id)
  end
end
