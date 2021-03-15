class CreateProprietaires < ActiveRecord::Migration[6.0]
  def change
    create_table :proprietaires do |t|
      t.string :prenom
      t.string :nom
      t.string :email
      t.integer :num_tel

      t.timestamps
    end
  end
end
