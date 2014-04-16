module SurveyRepresenter
  include Roar::Representer::JSON::HAL

  property :id

  link :self do
  end

  link :submit do
  end

  link :next do
  end
end
