require 'rails_helper'

feature 'Answering a scenario' do
  scenario 'it answers a survey', :vcr do
    user = create(:user)
    Poptart.authorize(service_user_id: user.service_user_id, user_token: user.token)

    survey = Poptart::Survey.create
    boolean_question = Poptart::Question.create(
      'Do you like poptarts?',
      question_type: 'boolean',
      responses: [true, false]
    )
    multiple_question = Poptart::Question.create(
      'Why do you eat poptarts?',
      question_type: 'multiple',
      responses: ["It's good", "It's bad"]
    )
    range_question = Poptart::Question.create(
      'How much do you like poptarts?',
      question_type: 'range',
      responses: [0, 10]
    )
    time_question = Poptart::Question.create(
      'When do you eat poptarts?',
      question_type: 'time'
    )

    boolean_survey_question = survey.add_survey_question(Poptart::SurveyQuestion.new('question_id' => boolean_question.id))
    survey.add_survey_question(Poptart::SurveyQuestion.new('question_id' => multiple_question.id))
    survey.add_survey_question(Poptart::SurveyQuestion.new('question_id' => range_question.id))
    survey.add_survey_question(Poptart::SurveyQuestion.new('question_id' => time_question.id))

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
