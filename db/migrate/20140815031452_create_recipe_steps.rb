class CreateRecipeSteps < ActiveRecord::Migration
  def change
    create_table :recipe_steps do |t|
      t.belongs_to :drink
      t.belongs_to :ingredient
      t.float :amount
      t.integer :group

      t.timestamps
    end
  end
end
