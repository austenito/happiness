class SurveyQuestion
  attr_accessor :survey_question
  delegate :id, :text, :boolean?, :multiple?, :range?, :time?,
           :responses, :freeform?, :answer, :submit,
           to: :survey_question

  def initialize(survey_question)
    @survey_question = survey_question
  end

  def update(attributes)
    return unless attributes[:survey_question]

    if @survey_question.time?
      @survey_question.answer = "#{attributes[:survey_question]['answer(4i)']}:#{attributes[:survey_question]['answer(5i)']}"
    else
      if attributes[:survey_question][:freeform_answer].present?
        @survey_question.answer = attributes[:survey_question][:freeform_answer]
      else
        @survey_question.answer = attributes[:survey_question][:answer]
      end
    end
  end
end
