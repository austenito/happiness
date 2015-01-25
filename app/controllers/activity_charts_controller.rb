class ActivityChartsController < ApplicationController
  respond_to :json

  def index
    activity_to_happiness = ActivityChart.new.calculate
    respond_with(categories: activity_to_happiness.keys,
                 values: activity_to_happiness.values)
  end
end
