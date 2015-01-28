class HappinessPlaceChart
  def calculate
    place_to_happiness = Hash.new { [] }
    surveys = Poptart::Survey.all

    surveys.each do |survey|
      if survey.completed?
        how_do_you_feel = survey.survey_questions.find { |survey_question| survey_question.key == 'how_do_you_feel_right_now' }
        where_are_you = survey.survey_questions.find { |survey_question| survey_question.key == 'where_are_you' }

        key = where_are_you.answer.downcase.to_sym
        values = place_to_happiness[key] << how_do_you_feel.answer.to_i
        place_to_happiness[key] = values
      end
    end

    place_to_happiness.each do |key, value|
      place_to_happiness[key] = (value.sum / value.size.to_f).round(2)
    end
    place_to_happiness
  end
end
