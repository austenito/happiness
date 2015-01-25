class DayChartsController < ApplicationController
  respond_to :json

  def index
    respond_with(
      categories: Date::DAYNAMES,
      values: HappinessDayChart.new(current_user.time_zone).calculate
    )
  end
end
