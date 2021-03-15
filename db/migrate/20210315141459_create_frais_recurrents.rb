class CreateFraisRecurrents < ActiveRecord::Migration[6.0]
  def change
    create_table :frais_recurrents do |t|
      t.string :nom
      t.integer :montant
      t.string :recurrence
      t.date :date_fin
      t.references :bien, null: false, foreign_key: true

      t.timestamps
    end
  end
end
