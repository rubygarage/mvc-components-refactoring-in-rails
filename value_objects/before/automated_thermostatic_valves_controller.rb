class AutomatedThermostaticValvesController < ApplicationController
  SCALES = %w(kelvin celsius fahrenheit)
  DEFAULT_SCALE = 'kelvin'
  MAX_TEMPERATURE = 25 + 273.15

  before_action :set_scale

  def heat_up
    was_heat_up = false
    if previous_temperature < next_temperature && next_temperature < MAX_TEMPERATURE
      valve.update(degrees: params[:degrees], scale: params[:scale])
      Heater.call(next_temperature)
      was_heat_up = true
    end
    render json: { was_heat_up: was_heat_up }
  end

  private

  def previous_temperature
    kelvin_degrees_by_scale(valve.degrees, valve.scale)
  end

  def next_temperature
    kelvin_degrees_by_scale(params[:degrees], @scale)
  end

  def set_scale
    @scale = SCALES.include?(params[:scale]) ? params[:scale] : DEFAULT_SCALE
  end

  def valve
    @valve ||= AutomatedThermostaticValve.find(params[:id])
  end

  def kelvin_degrees_by_scale(degrees, scale)
    degrees = degrees.to_f
    case scale.to_s
    when 'kelvin'
      degrees
    when 'celsius'
      degrees + 273.15
    when 'fahrenheit'
      (degrees - 32) * 5 / 9 + 273.15
    end
  end
end