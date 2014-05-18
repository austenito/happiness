class Survey
  attr_accessor :survey, :survey_questions
  delegate :id, :add_question, :survey_question_for_id, to: :survey

  def initialize(survey)
    @survey = survey
    @survey_questions = survey.survey_questions.sort_by { |survey_question| survey_question.id }
  end

  def self.for_id(id)
    new(Poptart::Survey.for_id(id))
  end

  def complete?
    next_question ? false : true
  end

  def next_question
    @survey_questions.find { |question| question.answer.nil? }
  end
end
