class SurveyQuestion
  extend Request

  attr_accessor :id, :text, :type, :answer

  def initialize(params = {})
    @id = params[:id]
    @answer = params[:answer]
    @submit_url = params[:submit_url]
  end

  def self.for_url(url)
    response = Faraday.get(url)
    SurveyQuestion.new.extend(SurveyQuestionRepresenter).from_json(response.body)
  end

  def submit_answer
    response = Faraday.post(submit_url + ".json", { id: id, survey_question: { answer: answer} })
    SurveyQuestion.new.extend(SurveyQuestionRepresenter).from_json(response.body)
  end

  def boolean?
    type == "BooleanQuestion"
  end

  def range?
    type == "BooleanQueston"
  end

  def multiple?
    type == "BooleanQueston"
  end

  def survey
    Survey.for_url(survey_url)
  end

  def survey_url
    links['survey']['href']
  end

  def submit_url
    @submit_url || links['submit']['href']
  end
end
