class CreateLandMarks < ActiveRecord::Migration[5.1]
  def change
    create_table :land_marks do |t|
      t.string :name, index: true

      t.timestamps
    end
  end
end
