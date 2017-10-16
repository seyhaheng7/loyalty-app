class AddColumnSentToPromotion < ActiveRecord::Migration[5.1]
  def change
    add_column :promotions, :sent, :boolean
  end
end
