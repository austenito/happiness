class HappinessPlaceChart
  attr_accessor :place_to_happiness

  def initialize(user)
    @user = user
    @place_to_happiness = Hash.new { [] }
  end

  def calculate
    surveys = @user.surveys

    surveys.each do |survey|
      if survey.completed?
        how_do_you_feel = survey.survey_questions.find { |survey_question| survey_question.key == 'how_do_you_feel_right_now' }
        where_are_you = survey.survey_questions.find { |survey_question| survey_question.key == 'where_are_you' }

        key = where_are_you.answer.to_sym
        values = @place_to_happiness[key] << how_do_you_feel.answer.to_i
        @place_to_happiness[key] = values
      end
    end

    @place_to_happiness.each do |key, value|
      @place_to_happiness[key] = value.sum / value.size
    end
  end
end
