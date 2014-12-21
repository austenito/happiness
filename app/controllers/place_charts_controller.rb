class PlaceChartsController < ApplicationController
  respond_to :json

  def index
    place_to_happiness = HappinessPlaceChart.new(current_user).calculate
    respond_with(places: place_to_happiness.keys,
                 values: place_to_happiness.values)
  end
end
