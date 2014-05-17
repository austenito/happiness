class SurveyQuestionsController < ApplicationController

  def index
    survey = Poptart::Survey.for_id(params[:survey_id])
    @survey_question = survey.next_question

    if @survey_question.blank?
      redirect_to surveys_path
    end
  end

  def show
    survey = Poptart::Survey.for_id(params[:survey_id])
    @survey_question = survey.survey_question_for_id(params[:id].to_i)
  end

  def update
    survey = Poptart::Survey.for_id(params[:survey_id])
    survey_question = survey.survey_question_for_id(params[:id])
    survey_question.answer = params[:survey_question][:answer]
    survey_question.submit

    if survey.complete?
      redirect_to survey_questions_path(survey_question.survey.id)
    else

    end
  end
end
