module SurveyQuestionRepresenter
  include Roar::Representer::JSON::HAL

  property :id
  property :text
  property :type
  property :answer

  link :self do
  end

  link :next do |args|
  end

  link :survey do
  end
end
