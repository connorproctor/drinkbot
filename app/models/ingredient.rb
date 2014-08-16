# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :text
#  alcoholic  :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Ingredient < ActiveRecord::Base

  has_many :recipe_steps
  has_many :drinks, through: :recipe_steps
  has_many :pumps

  validates_uniqueness_of :name

  def alcoholic?
    return alcoholic
  end

end
