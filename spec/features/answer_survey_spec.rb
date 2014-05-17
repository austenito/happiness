require 'spec_helper'

feature 'Answering a scenario' do
  scenario 'it answers a survey', :vcr, record: :all do
    survey = Poptart::Survey.create
    boolean_question = Poptart::Question.all(type: 'boolean').first
    multiple_question= Poptart::Question.all(type: 'multiple').first
    survey.add_question(boolean_question)
    survey.add_question(multiple_question)

    survey = Poptart::Survey.for_id(survey.id)
    boolean_survey_question = survey.survey_questions[0]
    multiple_survey_question = survey.survey_questions[1]

    visit survey_survey_question_path(survey.id, boolean_survey_question.id)

    page.should have_content boolean_survey_question.text
    choose('True')
    click_on 'Submit'

    page.should have_content multiple_survey_question.text
  end
end
