class CarsController < ApplicationController
  def show
    @car = Car.find(params[:id]).decorate
  end
end