# == Schema Information
#
# Table name: recipe_steps
#
#  id            :integer          not null, primary key
#  drink_id      :integer
#  ingredient_id :integer
#  amount        :integer
#  priority      :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class RecipeStep < ActiveRecord::Base

  belongs_to :ingredient
  belongs_to :drink
  # has_many :pumps, through: :ingredient

end
