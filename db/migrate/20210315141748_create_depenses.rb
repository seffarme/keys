class CreateDepenses < ActiveRecord::Migration[6.0]
  def change
    create_table :depenses do |t|
      t.string :nom
      t.integer :montant
      t.date :date_paiement
      t.references :bien, null: false, foreign_key: true
      t.references :frais_recurrent, null: true, foreign_key: true

      t.timestamps
    end
  end
end
