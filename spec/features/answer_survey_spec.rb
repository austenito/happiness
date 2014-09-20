require 'spec_helper'

feature 'Answering a scenario' do
  scenario 'it answers a survey', :vcr do
    user = create(:user)

    survey = user.create_survey
    boolean_question = Poptart::Question.all(type: 'boolean').first
    multiple_questions = Poptart::Question.all(type: 'multiple')
    multiple_question = Poptart::Question.all(type: 'multiple').first
    freeform_question = multiple_questions.reverse.find { |question| question.freeform? }
    range_question = Poptart::Question.all(type: 'range').first
    time_question = Poptart::Question.all(type: 'time').first
    survey.add_question(boolean_question)
    survey.add_question(multiple_question)
    survey.add_question(freeform_question)
    survey.add_question(range_question)
    survey.add_question(time_question)

    survey = user.survey_for_id(survey.id)
    boolean_survey_question = survey.survey_questions[0]
    multiple_survey_question = survey.survey_questions[1]
    freeform_survey_question = survey.survey_questions[2]
    range_survey_question = survey.survey_questions[3]
    time_survey_question = survey.survey_questions[4]

    login_as(user, scope: :user)
    visit survey_survey_question_path(survey.id, boolean_survey_question.id)

    page.should have_content boolean_survey_question.text
    click_on 'Submit'
    page.should have_content boolean_survey_question.text
    page.should have_content 'You must answer the question'
    choose('True')
    click_on 'Submit'

    page.should have_content multiple_survey_question.text
    choose(multiple_survey_question.responses.first)
    click_on 'Submit'

    page.should have_content freeform_survey_question.text
    fill_in 'survey_question[freeform_answer]', with: 'Poptarts'
    click_on 'Submit'

    page.should have_content range_survey_question.text
    choose(range_survey_question.responses.last)
    click_on 'Submit'

    page.should have_content time_survey_question.text
    click_on 'Submit'

    page.should have_content 't'
    page.should have_content multiple_survey_question.responses.first
    page.should have_content 'Poptarts'
    page.should have_content range_survey_question.responses.last
    page.should have_content 'Thanks for submitting your survey'
  end
end
