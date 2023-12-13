class CreateAdoptions < ActiveRecord::Migration[7.0]
  def change
    create_table :adoptions do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :pet, null: false, foreign_key: true
      t.references :adopter, null: false, foreign_key: { to_table: :users }
      t.datetime :date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
