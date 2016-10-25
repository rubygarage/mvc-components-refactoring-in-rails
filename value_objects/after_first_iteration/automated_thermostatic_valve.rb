class AutomatedThermostaticValve < ActiveRecord::Base
  SCALES = %w(kelvin celsius fahrenheit)
  DEFAULT_SCALE = 'kelvin'

  before_validation :check_next_temperature, if: :next_temperature
  after_save :launch_heater, if: :was_heat_up

  attr_accessor :next_degrees, :next_scale
  attr_reader :was_heat_up

  def temperature
    kelvin_degrees_by_scale(degrees, scale)
  end

  def next_temperature
    kelvin_degrees_by_scale(next_degrees, next_scale) if next_degrees.present?
  end

  def max_temperature
    kelvin_degrees_by_scale(25, 'celsius')
  end

  def next_scale=(scale)
    @next_scale = SCALES.include?(scale) ? scale : DEFAULT_SCALE
  end

  private

  def check_next_temperature
    @was_heat_up = false
    if temperature < next_temperature && next_temperature <= max_temperature
      @was_heat_up = true
      assign_attributes(
        degrees: next_degrees,
        scale: next_scale,
      )
    end
    @was_heat_up
  end

  def launch_heater
    Heater.call(temperature)
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