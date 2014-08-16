class CreatePumps < ActiveRecord::Migration
  def change
    create_table :pumps do |t|
      t.text :name
      t.integer :calibration
      t.belongs_to :ingredient

      t.timestamps
    end
  end
end
