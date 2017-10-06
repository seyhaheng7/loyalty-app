class CreateTermConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :term_conditions do |t|
      t.text :body

      t.timestamps
    end
  end
end
