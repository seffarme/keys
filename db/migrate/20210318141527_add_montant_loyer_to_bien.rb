class AddMontantLoyerToBien < ActiveRecord::Migration[6.0]
  def change
    add_column :biens, :montant_loyer, :integer
  end
end
