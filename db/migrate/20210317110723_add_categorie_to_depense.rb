class AddCategorieToDepense < ActiveRecord::Migration[6.0]
  def change
    add_column :depenses, :categorie, :string
  end
end
