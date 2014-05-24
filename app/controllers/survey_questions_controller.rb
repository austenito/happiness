class SurveyQuestionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    survey = Survey.for_id(params[:survey_id])
    @survey_question = survey.next_question

    if @survey_question.blank?
      redirect_to surveys_path
    end
  end

  def show
    @survey = current_user.survey_for_id(params[:survey_id])
    @survey_question = @survey.survey_question_for_id(params[:id].to_i)
  end

  def update
    survey = current_user.survey_for_id(params[:survey_id])
    survey_question = survey.survey_question_for_id(params[:id])
    if survey_question.time?
      survey_question.answer = "#{params[:survey_question]['answer(4i)']}:#{params[:survey_question]['answer(5i)']}"
    else
      survey_question.answer = params[:survey_question][:answer]
    end
    survey_question.submit

    if survey.complete?
      redirect_to survey_path(params[:survey_id])
    else
      redirect_to survey_survey_question_path(survey.id, survey.next_question.id)
    end
  end

  private

  def survey
    @survey ||= current_user.survey.for_id(params[:survey_id])
  end
end

