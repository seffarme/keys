class AddCategorieToFraisReccurents < ActiveRecord::Migration[6.0]
  def change
    add_column :frais_reccurents, :categorie, :string
  end
end
