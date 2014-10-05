# == Schema Information
#
# Table name: pumps
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  hardware_pin  :integer
#  calibration   :integer
#  ingredient_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Pump < ActiveRecord::Base

  belongs_to :ingredient

  def turn_on
    puts "Turning on pump #{self.id}"
    Arduino.instance.turn_on self.hardware_pin
  end

  def turn_off
    puts "Turning off pump #{self.id}"
    Arduino.instance.turn_off self.hardware_pin
  end


  def self.turn_on_all
    Pump.all.each do |pump|
      pump.turn_on
    end
  end

  def self.turn_off_all
    Pump.all.each do |pump|
      pump.turn_off
    end
  end

end
