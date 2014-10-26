class Survey
  attr_accessor :survey, :survey_questions
  delegate :id, :add_question, to: :survey

  def initialize(survey)
    @survey = survey
    @survey_questions = survey.survey_questions.map { |survey_question| SurveyQuestion.new(survey_question) }
  end

  def self.for_id(id)
    new(Poptart::Survey.for_id(id))
  end

  def survey_question_for_id(id)
    @survey_questions.find { |survey_question| survey_question.id == id.to_i }
  end

  def complete?
    next_question ? false : true
  end

  def next_question
    @survey_questions.find { |question| question.answer.nil? }
  end
end
