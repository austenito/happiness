class HappinessDayChart
  attr_accessor :day_to_happiness

  def initialize(user)
    @user = user
  end

  def calculate
    day_to_happiness = {}
    7.times { |i| day_to_happiness[i] = [] }

    survey_questions = @user.service_user.survey_questions_for_key(:how_do_you_feel_right_now)
    survey_questions.each do |survey_question|
      survey_question_created_at = survey_question.created_at.in_time_zone(@user.time_zone)
      day_of_week = survey_question_created_at.cwday
      day_of_week = 0 if survey_question_created_at.sunday?
      day_values = day_to_happiness[day_of_week] << survey_question.answer.to_i
      day_to_happiness[day_of_week] = day_values
    end

    day_to_happiness.map do |key, value|
      if value.empty?
        day_to_happiness[key] = 0
      else
        day_to_happiness[key] = value.sum / value.size
      end
    end
  end
end
