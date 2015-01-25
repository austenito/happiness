class PlaceChartsController < ApplicationController
  respond_to :json

  def index
    place_to_happiness = HappinessPlaceChart.new.calculate
    respond_with(categories: place_to_happiness.keys,
                 values: place_to_happiness.values)
  end
end
