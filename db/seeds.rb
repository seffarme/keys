# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


##########################################################################
# Cleaning process

puts "//////////////////////////////////////////////////////"
puts "Starting the DB cleaning process"

puts "1/6- Cleaning the Locataire DB..."
Locataire.destroy_all

puts "2/6 - Cleaning the Loyer DB..."
Loyer.destroy_all

puts "3/6 - Cleaning the Depense DB..."
Depense.destroy_all

puts "4/6 - Cleaning the Frais_recurrent DB..."
FraisRecurrent.destroy_all

puts "5/6 - Cleaning the Bien DB..."
Bien.destroy_all

puts "6/6 - Cleaning the User DB..."
User.destroy_all

puts "All DB cleaned up"
puts "//////////////////////////////////////////////////////"



##########################################################################
# Creating process

puts "//////////////////////////////////////////////////////"
puts "Starting the seeding process..."


### - # - ###
# User
queen_elizabeth = User.new({
    prenom: "Elizabeth",
    nom: "Windsor",
    email: "julie.laloy@gmail.com",
    num_tel: "0614514502",
    password: "123456"
})
queen_elizabeth.save


### - # - ###
# Bien
buckingham_palace_en_correze = Bien.new({
    nom: "Buckingham Palace en Corrèze",
    categorie: "Maison",
    adresse: "6 chemin de Peyrafort",
    ville: "Tulle",
    code_postal: "19000",
    pays: "France",
    info_compl_adresse: "Très belle maison de campagne avec vue dégagée sur Tulle",
    surface: "250",
    nb_pieces: "6",
    nb_sdb: "2",
    nb_etages: "2",
    num_etage: "0",
    annee_construction: "01/01/1950",
    prix_acquisition: "150000",
    date_acquisition: "01/01/2010",
    frais_achat_notaire: "10000",
    frais_achat_agence: "5000",
    frais_achat_travaux: "5000",
    frais_achat_autres: "500"
})

buckingham_palace_en_correze.user = queen_elizabeth
buckingham_palace_en_correze.save


### - # - ###
# Frais recurents
emprunt_bpec = FraisRecurrent.new({
    nom: "Prêt amortissable",
    montant: "170500",
    recurrence: "Mensuel",
    date_fin: "01/01/2030"
})

emprunt_bpec.bien = buckingham_palace_en_correze
emprunt_bpec.save


taxe_fonciere_bpec = FraisRecurrent.new({
    nom: "Taxe foncière",
    montant: "2000",
    recurrence: "Annuel",
    date_fin: "01/01/2099"
})

taxe_fonciere_bpec.bien = buckingham_palace_en_correze
taxe_fonciere_bpec.save

charges_bpec = FraisRecurrent.new({
    nom: "Charges",
    montant: "600",
    recurrence: "Annuel",
    date_fin: "01/01/2099"
})

charges_bpec.bien = buckingham_palace_en_correze
charges_bpec.save


### - # - ###
# Depenses
travaux_bal = Depense.new({
    nom: "Travaux boîte aux lettres",
    montant: "200",
    date_paiement: "01/02/2021"
})

travaux_bal.bien = buckingham_palace_en_correze
travaux_bal.save


### - # - ###
# Locataire
françois_hollande = Locataire.new({
    prenom: "François",
    nom: "Hollande",
    email: "françois.hollande@gmail.com",
    num_tel: "0614514503",
    adresse: "Avenue Montaigne",
    ville: "Paris",
    code_postal: "75008",
    pays: "France",
    date_debut_location: "01/01/2020"
})
françois_hollande.bien = buckingham_palace_en_correze
françois_hollande.save


### - # - ###
# Loyers
loyer_20200101 = Loyer.new({
    montant: "500",
    date_paiement: "01/01/2020"
})
loyer_20200101.bien = buckingham_palace_en_correze
loyer_20200101.save

loyer_20200201 = Loyer.new({
    montant: "500",
    date_paiement: "01/02/2020"
})
loyer_20200201.bien = buckingham_palace_en_correze
loyer_20200201.save

loyer_20200301 = Loyer.new({
    montant: "500",
    date_paiement: "01/03/2020"
})
loyer_20200301.bien = buckingham_palace_en_correze
loyer_20200301.save