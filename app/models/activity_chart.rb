class ActivityChart
  def calculate
    activity_to_happiness = Hash.new { [] }
    surveys = Poptart::Survey.all

    surveys.each do |survey|
      if survey.completed?
        how_do_you_feel = survey.survey_questions.find { |survey_question| survey_question.key == 'how_do_you_feel_right_now' }
        what_are_you_doing = survey.survey_questions.find { |survey_question| survey_question.key == 'what_are_you_doing' }

        if what_are_you_doing
          key = what_are_you_doing.answer.downcase.to_sym
          values = activity_to_happiness[key] << how_do_you_feel.answer.to_i
          activity_to_happiness[key] = values
        end
      end
    end

    activity_to_happiness.each do |key, value|
      activity_to_happiness[key] = value.sum / value.size
    end
    activity_to_happiness
  end
end
