class Arduino
  def initialize
    # @arduino = ArduinoFirmata.connect
  end

  @@instance = Arduino.new

  def self.instance
    @@instance
  end

  def turn_on_pump(pump)
    puts "Turning on pump #{pump.id}"
  end

  def turn_off_pump(pump)
    puts "Turning off pump #{pump.id}"
  end

  private_class_method :new
end