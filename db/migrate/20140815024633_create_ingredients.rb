class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.text :name
      t.boolean :alcoholic

      t.timestamps
    end
  end
end
