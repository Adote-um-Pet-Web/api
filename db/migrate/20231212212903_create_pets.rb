class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :species
      t.string :breed
      t.integer :age
      t.integer :age_type
      t.string :color
      t.integer :sex
      t.integer :size
      t.integer :weight
      t.text :history
      t.text :observations
      t.boolean :adopted, default: false
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
