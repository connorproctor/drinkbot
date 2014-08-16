class CreateRecipeSteps < ActiveRecord::Migration
  def change
    create_table :recipe_steps do |t|
      t.belongs_to :drink
      t.belongs_to :ingredient
      t.integer :amount
      t.integer :manual_delay

      t.timestamps
    end
  end
end
