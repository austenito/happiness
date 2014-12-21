class DayChartsController < ApplicationController
  respond_to :json

  def index
    respond_with HappinessDayChart.new(current_user).calculate
  end
end
