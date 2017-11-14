class SetPromotionSentDedault < ActiveRecord::Migration[5.1]
  def change
    change_column :promotions, :sent, :boolean, default: false
  end
end
