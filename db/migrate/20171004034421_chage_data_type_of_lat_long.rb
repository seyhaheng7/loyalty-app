class ChageDataTypeOfLatLong < ActiveRecord::Migration[5.1]
  def change
    remove_column :advertisements, :lat
    remove_column :advertisements, :long
    add_column :advertisements, :lat, :float
    add_column :advertisements, :long, :float
  end
end
