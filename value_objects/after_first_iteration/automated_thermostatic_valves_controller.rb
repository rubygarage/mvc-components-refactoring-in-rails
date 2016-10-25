class AutomatedThermostaticValvesController < ApplicationController
  def heat_up
    valve.update(next_degrees: params[:degrees], next_scale: params[:scale])

    render json: { was_heat_up: valve.was_heat_up }
  end

  private

  def valve
    @valve ||= AutomatedThermostaticValve.find(params[:id])
  end
end