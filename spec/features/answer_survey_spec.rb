require 'spec_helper'

feature 'Answering a scenario' do
  scenario 'it answers a survey', :vcr do
    user = create(:user)
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)

    survey = user.create_survey
    boolean_question = Poptart::BooleanQuestion.create('Do you like poptarts?')
    multiple_question = Poptart::MultipleResponseQuestion.create('Why do you eat poptarts?', responses: ["It's good", "It's bad"], freeform: true)
    range_question = Poptart::RangeQuestion.create("How much do you like poptarts", responses: [0, 10])
    time_question = Poptart::TimeQuestion.create("When do you eat poptarts")
    boolean_survey_question =  survey.add_question(boolean_question)
    survey.add_question(multiple_question)
    survey.add_question(range_question)
    survey.add_question(time_question)

    login_as(user, scope: :user)
    visit survey_survey_question_path(survey.id, boolean_survey_question.id)

    page.should have_content 'Do you like poptarts'
    click_on 'Submit'
    page.should have_content 'You must answer the question'
    choose('True')
    click_on 'Submit'

    page.should have_content 'Why do you eat poptarts?'
    page.should have_content "It's good"
    page.should have_content "It's bad"
    fill_in 'survey_question[freeform_answer]', with: 'I want to'
    click_on 'Submit'

    page.should have_content "How much do you like poptarts"
    choose(10)
    click_on 'Submit'

    page.should have_content "When do you eat poptarts"
    all('select.time').first.select('10')
    all('select.time').last.select('45')
    click_on 'Submit'

    page.should have_content 'true'
    page.should have_content 'I want to'
    page.should have_content '10'
    page.should have_content '10:45'
    page.should have_content 'Thanks for submitting your survey'
  end
end
