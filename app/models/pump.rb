class Pump < ActiveRecord::Base

  belongs_to :ingredient

  validates_uniqueness_of :name

end
