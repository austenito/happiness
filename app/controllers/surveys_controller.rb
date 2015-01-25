class SurveysController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @survey = Survey.for_id(params[:id])
  end

  def create
    survey = Survey.create
    redirect_to survey_survey_question_path(survey.id, survey.survey_questions.first.id)
  end
end
