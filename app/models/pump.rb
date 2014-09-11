# == Schema Information
#
# Table name: pumps
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  calibration   :integer
#  ingredient_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Pump < ActiveRecord::Base

  belongs_to :ingredient

end
