class RecipeStep < ActiveRecord::Base

  belongs_to :ingredient
  belongs_to :drink
  # has_many :pumps, through: :ingredient

end
