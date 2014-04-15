class QuestionsController < ApplicationController

  def index
    connection = create_connection
    response = connection.get do |req|
       req.url("/api/surveys/#{params[:survey_id]}")
       req.headers['Content-Type'] = 'application/json'
    end

    parsed_response = JSON.parse(response.body)
    links = parsed_response['_links']
    if links['next']
      response = Faraday.get(links['next']['href'])
      parsed_response = JSON.parse(response.body)
      @text = parsed_response['text']
      @question_id = parsed_response['id']
      @submit_url = links['submit']['href']
    else
      redirect_to surveys_path
    end
  end

  def create
    response = Faraday.post(params[:submit_url] + ".json", { id: params[:id], survey_question: { answer: params[:question][:answer] } })

    parsed_response = JSON.parse(response.body)
    survey_response = Faraday.get(parsed_response['_links']['survey']['href'])
    parsed_response = JSON.parse(survey_response.body)
    redirect_to survey_questions_path(parsed_response['id'])
  end
end
