require 'spec_helper'

feature 'Answering a scenario' do
  scenario 'it answers a survey', :vcr, record: :all do
    survey = Poptart::Survey.create
    boolean_question = Poptart::Question.all(type: 'boolean').first
    multiple_question = Poptart::Question.all(type: 'multiple').first
    range_question = Poptart::Question.all(type: 'range').first
    time_question = Poptart::Question.all(type: 'time').first
    survey.add_question(boolean_question)
    survey.add_question(multiple_question)
    survey.add_question(range_question)
    survey.add_question(time_question)

    survey = Poptart::Survey.for_id(survey.id)
    boolean_survey_question = survey.survey_questions[0]
    multiple_survey_question = survey.survey_questions[1]
    range_survey_question = survey.survey_questions[2]
    time_survey_question = survey.survey_questions[3]

    visit survey_survey_question_path(survey.id, boolean_survey_question.id)

    page.should have_content boolean_survey_question.text
    choose('True')
    click_on 'Submit'

    page.should have_content multiple_survey_question.text
    choose(multiple_survey_question.responses.last)
    click_on 'Submit'

    page.should have_content range_survey_question.text
    choose(range_survey_question.responses.last)
    click_on 'Submit'

    page.should have_content time_survey_question.text
    click_on 'Submit'

    page.should have_content 't'
    page.should have_content multiple_survey_question.responses.last
    page.should have_content range_survey_question.responses.last
    page.should have_content 'Thanks for submitting your survey'
  end
end
