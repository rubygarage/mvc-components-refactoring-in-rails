class AutomatedThermostaticValve < ActiveRecord::Base
  before_validation :check_next_temperature, if: :next_temperature
  after_save :launch_heater, if: :was_heat_up

  attr_accessor :next_degrees, :next_scale
  attr_reader :was_heat_up

  def temperature
    Temperature.new(degrees, scale)
  end

  def temperature=(temperature)
    assign_attributes(temperature.to_h)
  end

  def next_temperature
    Temperature.new(next_degrees, next_scale) if next_degrees.present?
  end

  private

  def check_next_temperature
    @was_heat_up = false
    if temperature < next_temperature && next_temperature <= Temperature::MAX
      self.temperature = next_temperature
      @was_heat_up = true
    end
  end

  def launch_heater
    Heater.call(temperature.kelvin_degrees)
  end
end