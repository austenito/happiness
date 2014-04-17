class SurveysController < ApplicationController

  def index
  end

  def create
    survey = Survey.create
    redirect_to survey_questions_path(survey.id)
  end
end
