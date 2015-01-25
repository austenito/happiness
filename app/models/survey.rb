class Survey
  attr_accessor :survey, :survey_questions
  delegate :id, :add_question, to: :survey

  def initialize(survey)
    @survey = survey
    @survey_questions = survey.survey_questions.map { |survey_question| SurveyQuestion.new(survey_question) }
  end

  def self.for_id(id)
    new(Poptart::Survey.find(id))
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

  def self.create
    survey = Poptart::Survey.create
    questions = []
    questions << Poptart::Question.find('how_do_you_feel_right_now')
    questions << Poptart::Question.find('where_are_you')
    questions << Poptart::Question.find('what_are_you_doing')

    other_questions = Poptart::Question.all.select do |question|
      question.key != 'how_do_you_feel_right_now' && question.key != 'where_are_you' &&
        question.key != 'what_are_you_doing'
    end

    questions += other_questions.shuffle.take(2)

    questions.each do |question|
      survey_question = Poptart::SurveyQuestion.new('question_id' => question.id)
      survey.add_survey_question(survey_question)
    end

    new(survey)
  end
end
