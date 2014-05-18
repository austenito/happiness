class SurveyQuestionsController < ApplicationController

  def index
    survey = Survey.for_id(params[:survey_id])
    @survey_question = survey.next_question

    if @survey_question.blank?
      redirect_to surveys_path
    end
  end

  def show
    @survey = Survey.for_id(params[:survey_id])
    @survey_question = @survey.survey_question_for_id(params[:id].to_i)
  end

  def update
    survey = Survey.for_id(params[:survey_id])
    survey_question = survey.survey_question_for_id(params[:id])
    survey_question.answer = params[:survey_question][:answer]
    survey_question.submit

    if survey.complete?
      redirect_to survey_path(params[:survey_id])
    else
      redirect_to survey_survey_question_path(survey.id, survey.next_question.id)
    end
  end
end
