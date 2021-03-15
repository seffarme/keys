class CreateLocataires < ActiveRecord::Migration[6.0]
  def change
    create_table :locataires do |t|
      t.string :prenom
      t.string :nom
      t.string :email
      t.integer :num_tel
      t.string :adresse
      t.string :ville
      t.integer :code_postal
      t.string :pays
      t.date :date_debut_location
      t.references :bien, null: false, foreign_key: true

      t.timestamps
    end
  end
end
