# == Schema Information
#
# Table name: drinks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  image_path :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Drink < ActiveRecord::Base

  has_many :recipe_steps, autosave: true
  has_many :ingredients, through: :recipe_steps

  validates :name, uniqueness: true, presence: true

  def image_path
    "assets/drinks/#{read_attribute(:image_path)}"
  end
end
