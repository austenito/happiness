class HappinessDayChart
  attr_accessor :day_to_happiness

  def initialize(user)
    @user = user
    @day_to_happiness = Hash.new { [] }
  end

  def calculate
    survey_questions = @user.service_user.survey_questions_for_key(:how_do_you_feel_right_now)
    survey_questions.each do |survey_question|
      day_of_week = survey_question.created_at.cwday
      day_of_week = 0 if survey_question.created_at.sunday?
      day_values = @day_to_happiness[day_of_week] << survey_question.answer.to_i
      @day_to_happiness[day_of_week] = day_values
    end

    @day_to_happiness.each do |key, value|
      @day_to_happiness[key] = value.sum / value.size
    end
  end
end
