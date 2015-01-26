require 'rails_helper'

describe SurveysController do
  context '#create' do
    before do
      allow(controller).to receive(:authenticate_user!)
    end

    it 'creates an interaction survey a third of the time' do
      survey_question = double(:survey_question, id: 42)
      survey = double(:survey, id: 1, survey_questions: [survey_question])
      allow(Survey).to receive(:create_with_interaction).and_return(survey)
      allow(Random).to receive(:rand).and_return(9)

      post :create

      expect(Survey).to have_received(:create_with_interaction)
      expect(response).to redirect_to(survey_survey_question_path(1, 42))
    end

    it 'creates a random survey' do
      survey_question = double(:survey_question, id: 42)
      survey = double(:survey, id: 1, survey_questions: [survey_question])
      allow(Survey).to receive(:create).and_return(survey)
      allow(Random).to receive(:rand).and_return(10)

      post :create

      expect(Survey).to have_received(:create)
      expect(response).to redirect_to(survey_survey_question_path(1, 42))
    end
  end
end
