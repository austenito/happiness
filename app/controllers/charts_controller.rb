class ChartsController < ApplicationController
  respond_to :json

  def show
    if params[:id] == 'daily'
      daily_chart = DailyChart.new(current_user.time_zone)
      daily_chart.calculate
      respond_with(
        categories: daily_chart.average_happiness_by_date.keys,
        values: daily_chart.average_happiness_by_date.to_a
      )
    elsif params[:id] == 'activity'
      activity_to_happiness = ActivityChart.new.calculate
      respond_with(
        categories: activity_to_happiness.keys,
        values: activity_to_happiness.values
      )
    elsif params[:id] == 'per-day'
      respond_with(
        categories: Date::DAYNAMES,
        values: HappinessDayChart.new(current_user.time_zone).calculate
      )
    elsif params[:id] == 'places'
      place_to_happiness = HappinessPlaceChart.new.calculate
      respond_with(
        categories: place_to_happiness.keys,
        values: place_to_happiness.values
      )
    end
  end
end
