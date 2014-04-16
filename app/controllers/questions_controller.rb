class QuestionsController < ApplicationController

  def index
    survey = Survey.for_id(params[:survey_id])
    @survey_question = survey.next_question

    if @survey_question.blank?
      redirect_to surveys_path
    end
  end

  def create
    survey_question = SurveyQuestion.new(id: params[:id], answer: params[:survey_question][:answer], submit_url: params[:submit_url])
    survey_question = survey_question.submit_answer
    redirect_to survey_questions_path(survey_question.survey.id)
  end
end
