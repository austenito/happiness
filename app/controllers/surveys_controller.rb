class SurveysController < ApplicationController
  before_filter :authenticate_user!

  def index
    @days_of_the_week = Date::DAYNAMES
    chart = HappinessDayChart.new(current_user)
    chart.calculate
    @day_to_happiness = chart.day_to_happiness

    place_chart = HappinessPlaceChart.new(current_user)
    place_chart.calculate
    @place_to_happiness = place_chart.place_to_happiness
  end

  def show
    @survey = current_user.survey_for_id(params[:id])
  end

  def create
    survey = current_user.create_random_survey
    redirect_to survey_survey_question_path(survey.id, survey.survey_questions.first.id)
  end
end
