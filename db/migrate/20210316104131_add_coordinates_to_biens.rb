class AddCoordinatesToBiens < ActiveRecord::Migration[6.0]
  def change
    add_column :biens, :latitude, :float
    add_column :biens, :longitude, :float
  end
end
