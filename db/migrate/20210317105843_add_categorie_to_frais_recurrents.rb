class AddCategorieToFraisRecurrents < ActiveRecord::Migration[6.0]
  def change
    add_column :frais_recurrents, :categorie, :string
  end
end
