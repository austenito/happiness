class Survey
  extend Request

  attr_accessor :id

  def self.create
    response = post("/api/surveys")
    Survey.new.extend(SurveyRepresenter).from_json(response.body)
  end

  def self.for_id(id)
    response = get("/api/surveys/#{id}")
    Survey.new.extend(SurveyRepresenter).from_json(response.body)
  end

  def self.for_url(url)
    response = Faraday.get(url)
    Survey.new.extend(SurveyRepresenter).from_json(response.body)
  end

  def next_question
    if links['next']
      SurveyQuestion.for_url(links['next']['href'])
    end
  end
end
