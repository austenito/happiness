class SurveysController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @survey = Survey.for_id(params[:id])
  end

  def create
    if Random.rand(10) % 3 == 0
      survey = Survey.create_with_interaction
    else
      survey = Survey.create
    end
    redirect_to survey_survey_question_path(survey.id, survey.survey_questions.first.id)
  end
end
