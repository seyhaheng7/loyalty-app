class CreateRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :rewards do |t|
      t.string :name
      t.string :image
      t.integer :require_points
      t.integer :quantity, default: 0
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
