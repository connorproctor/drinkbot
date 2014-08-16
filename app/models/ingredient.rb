class Ingredient < ActiveRecord::Base

  has_many :recipe_steps
  has_many :drinks, through: :recipe_steps
  has_many :pumps

  validates_uniqueness_of :name

  def alcoholic?
    return alcoholic
  end

end
