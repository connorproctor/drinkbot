# == Schema Information
#
# Table name: drinks
#
#  id         :integer          not null, primary key
#  name       :text
#  image_path :text
#  created_at :datetime
#  updated_at :datetime
#

class Drink < ActiveRecord::Base

  has_many :recipe_steps
  has_many :ingredients, through: :recipe_steps

  validates :name, uniqueness: true, presence: true
  validates :ingredients, presence: true
end
