class SurveysController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @survey = current_user.survey_for_id(params[:id])
  end

  def create
    survey = current_user.create_random_survey
    redirect_to survey_survey_question_path(survey.id, survey.survey_questions.first.id)
  end
end
