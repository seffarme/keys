class CreateBiens < ActiveRecord::Migration[6.0]
  def change
    create_table :biens do |t|
      t.string :nom
      t.string :categorie
      t.string :adresse
      t.string :ville
      t.integer :code_postal
      t.string :pays
      t.string :info_compl_adresse
      t.integer :surface
      t.integer :nb_pieces
      t.integer :nb_sdb
      t.integer :num_etage
      t.integer :nb_etages
      t.integer :annee_construction
      t.integer :prix_acquisition
      t.date :date_acquisition
      t.integer :frais_achat_notaire
      t.integer :frais_achat_agence
      t.integer :frais_achat_travaux
      t.integer :frais_achat_autres
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
