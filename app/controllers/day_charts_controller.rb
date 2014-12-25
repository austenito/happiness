class DayChartsController < ApplicationController
  respond_to :json

  def index
    respond_with(
      categories: Date::DAYNAMES,
      values: HappinessDayChart.new(current_user).calculate
    )
  end
end
