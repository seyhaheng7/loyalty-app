class CreateReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :receipts do |t|
      t.string :receipt_id
      t.float :total
      t.string :capture
      t.integer :earned_points
      t.string :status
      t.references :store, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
