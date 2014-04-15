class SurveysController < ApplicationController
  def index
  end

  def create
    connection = create_connection
    response = connection.post do |req|
       req.url("/api/surveys")
       req.headers['Content-Type'] = 'application/json'
    end

    parsed_response = JSON.parse(response.body)
    redirect_to survey_questions_path(parsed_response['id'])
  end
end
