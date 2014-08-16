class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.text :name
      t.text :image_path

      t.timestamps
    end
  end
end
