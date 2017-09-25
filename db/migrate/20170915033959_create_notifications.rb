class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :notification_type
      t.string :text

      t.references :notifyable, polymorphic: true
      t.references :objectable, polymorphic: true

      t.timestamps
    end
  end
end
