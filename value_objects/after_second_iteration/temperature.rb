class Temperature
  include Comparable
  SCALES = %w(kelvin celsius fahrenheit)
  DEFAULT_SCALE = 'kelvin'

  attr_reader :degrees, :scale, :kelvin_degrees

  def initialize(degrees, scale = 'kelvin')
    @degrees = degrees.to_f
    @scale = case scale
    when *SCALES then scale
    else DEFAULT_SCALE
    end

    @kelvin_degrees = case @scale
    when 'kelvin'
      @degrees
    when 'celsius'
      @degrees + 273.15
    when 'fahrenheit'
      (@degrees - 32) * 5 / 9 + 273.15
    end
  end

  def self.from_celsius(degrees_celsius)
    new(degrees_celsius, 'celsius')
  end

  def self.from_fahrenheit(degrees_fahrenheit)
    new(degrees_celsius, 'fahrenheit')
  end

  def self.from_kelvin(degrees_kelvin)
    new(degrees_kelvin, 'kelvin')
  end

  def <=>(other)
    kelvin_degrees <=> other.kelvin_degrees
  end

  def to_h
    { degrees: degrees, scale: scale }
  end

  MAX = from_celsius(25)
end