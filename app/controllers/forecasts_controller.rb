class ForecastsController < ApplicationController

  respond_to :html

  def new
    @forecast = Forecast.new
  end

  def create
    @forecast = Forecast.new(params[:forecast])
    respond_with(@forecast)
  end
end
