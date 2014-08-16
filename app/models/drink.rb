class Drink < ActiveRecord::Base

  has_many :recipe_steps
  has_many :ingredients, through: :recipe_steps

  validates :name, uniqueness: true, presence: true
  validates :ingredients, presence: true
end
