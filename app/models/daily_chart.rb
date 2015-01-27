class DailyChart
  attr_accessor :average_happiness_by_date

  def initialize(time_zone)
    @time_zone = time_zone
    @average_happiness_by_date = {}
  end

  def calculate
    happiness_by_date = Hash.new { [] }

    survey_questions = Poptart::SurveyQuestion.find_all(key: 'how_do_you_feel_right_now')
    survey_questions.each do |survey_question|
      survey_question_created_at = survey_question.created_at.in_time_zone(@time_zone).to_date

      daily_array = happiness_by_date[survey_question_created_at]
      daily_array << survey_question.answer.to_i
      happiness_by_date[survey_question_created_at] = daily_array
    end

    happiness_by_date.map do |key, value|
      average_happiness_by_date[key] = value.sum / value.size
    end
    happiness_by_date.sort
  end
end
