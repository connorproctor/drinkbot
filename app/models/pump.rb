# == Schema Information
#
# Table name: pumps
#
#  id            :integer          not null, primary key
#  name          :text
#  calibration   :integer
#  ingredient_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Pump < ActiveRecord::Base

  belongs_to :ingredient

  validates_uniqueness_of :name

end
