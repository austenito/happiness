class SurveysController < ApplicationController

  def index
  end

  def create
    survey = Poptart::Survey.create_random
    redirect_to survey_survey_question_path(survey.id, survey.survey_questions.first.id)
  end
end
