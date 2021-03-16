class AddDateDebutToFraisRecurrents < ActiveRecord::Migration[6.0]
  def change
    add_column :frais_recurrents, :date_debut, :date
  end
end
