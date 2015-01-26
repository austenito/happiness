require 'rails_helper'

describe Survey do
  context '.for_id' do
    it 'finds survey by id' do
      survey = double
      allow(Survey).to receive(:new).and_return(survey)
      allow(Poptart::Survey).to receive(:find)

      returned_survey = Survey.for_id(1)

      expect(Poptart::Survey).to have_received(:find).with(1)
      expect(returned_survey).to eq(survey)
    end
  end

  context '.create' do
    it 'creates a survey with default questions' do
      service_survey = double
      how_do_you_feel_question = double(:question, id: 1, key: 'how_do_you_feel_right_now')
      where_are_you_question = double(:question, id: 2, key: 'where_are_you')
      what_are_you_doing_question = double(:question, id: 3, key: 'what_are_you_doing')
      other_question = double(:question, id: 4, key: 'other_question')
      yet_another_question = double(:question, id: 5, key: 'yet_another_question')
      yet_another_question2 = double(:question, id: 6, key: 'yet_another_question')
      all_questions = [
        how_do_you_feel_question,
        where_are_you_question,
        what_are_you_doing_question,
        other_question,
        yet_another_question,
        yet_another_question2
      ]

      allow(Poptart::Survey).to receive(:create).and_return(service_survey)
      allow(Poptart::Question).to receive(:find).with('how_do_you_feel_right_now').
        and_return(how_do_you_feel_question)
      allow(Poptart::Question).to receive(:find).with('where_are_you').
        and_return(how_do_you_feel_question)
      allow(Poptart::Question).to receive(:find).with('what_are_you_doing').
        and_return(how_do_you_feel_question)
      allow(Poptart::Question).to receive(:all).and_return(all_questions)
      allow(service_survey).to receive(:add_survey_question)

      survey = double
      allow(Survey).to receive(:new).and_return(survey)

      returned_survey = Survey.create

      expect(Poptart::Question).to have_received(:find).with('how_do_you_feel_right_now')
      expect(Poptart::Question).to have_received(:find).with('where_are_you')
      expect(Poptart::Question).to have_received(:find).with('what_are_you_doing')
      expect(service_survey).to have_received(:add_survey_question).exactly(5).times
      expect(returned_survey).to eq(survey)
    end
  end

  context '.create_interaction_survey' do
    it 'creates a survey with interaction questions' do
      service_survey = double
      how_do_you_feel_question = double(:question, id: 1, key: 'how_do_you_feel_right_now')
      where_are_you_question = double(:question, id: 2, key: 'where_are_you')
      what_are_you_doing_question = double(:question, id: 3, key: 'what_are_you_doing')
      are_you_alone_question = double(:question, id: 4, key: 'are_you_alone')
      talking_question = double(:question, id: 5, key: 'how_many_people_are_you_talking_with')
      all_questions = [
        how_do_you_feel_question,
        where_are_you_question,
        what_are_you_doing_question,
        are_you_alone_question,
        talking_question
      ]

      allow(Poptart::Survey).to receive(:create).and_return(service_survey)
      allow(Poptart::Question).to receive(:find).with('how_do_you_feel_right_now').
        and_return(how_do_you_feel_question)
      allow(Poptart::Question).to receive(:find).with('where_are_you').
        and_return(how_do_you_feel_question)
      allow(Poptart::Question).to receive(:find).with('what_are_you_doing').
        and_return(how_do_you_feel_question)
      allow(Poptart::Question).to receive(:find).with('are_you_alone').
        and_return(are_you_alone_question)
      allow(Poptart::Question).to receive(:find).with('how_many_people_are_you_talking_with').
        and_return(talking_question)
      allow(service_survey).to receive(:add_survey_question)

      survey = double
      allow(Survey).to receive(:new).and_return(survey)

      returned_survey = Survey.create_with_interaction

      expect(Poptart::Question).to have_received(:find).with('how_do_you_feel_right_now')
      expect(Poptart::Question).to have_received(:find).with('where_are_you')
      expect(Poptart::Question).to have_received(:find).with('what_are_you_doing')
      expect(Poptart::Question).to have_received(:find).with('are_you_alone')
      expect(Poptart::Question).to have_received(:find).with('how_many_people_are_you_talking_with')
      expect(service_survey).to have_received(:add_survey_question).exactly(5).times
      expect(returned_survey).to eq(survey)
    end
  end
end


