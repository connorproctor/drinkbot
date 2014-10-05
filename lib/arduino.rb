class Arduino
  def initialize
    @arduino = ArduinoFirmata.connect
  rescue ArduinoFirmata::Error => e
    puts "Arduino not found. Running in Arduinoless mode."
    @arduino = nil
  end

  @@instance = Arduino.new

  def self.instance
    @@instance
  end

  def turn_on(pin)
    @arduino.digital_write pin, true if @arduino
  end

  def turn_off(pin)
    @arduino.digital_write pin, false if @arduino
  end

  private_class_method :new
end