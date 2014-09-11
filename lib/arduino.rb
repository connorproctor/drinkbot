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

  def turn_on_pump(pump)
    puts "Turning on pump #{pump.id}"
    @arduino.digital_write pump.name.to_i, true if @arduino
  end

  def turn_off_pump(pump)
    puts "Turning off pump #{pump.id}"
    @arduino.digital_write pump.name.to_i, false if @arduino
  end

  def turn_on_pumps
    Pump.all.each do |pump|
      turn_on_pump(pump)
    end
  end

  def turn_off_pumps
    Pump.all.each do |pump|
      turn_off_pump(pump)
    end
  end

  private_class_method :new
end