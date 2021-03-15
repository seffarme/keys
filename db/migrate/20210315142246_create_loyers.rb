class CreateLoyers < ActiveRecord::Migration[6.0]
  def change
    create_table :loyers do |t|
      t.integer :montant
      t.date :date_paiement
      t.references :bien, null: false, foreign_key: true
      t.references :locataire, null: false, foreign_key: true

      t.timestamps
    end
  end
end
