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

puts "1/6 - Cleaning the Loyer DB..."
Loyer.destroy_all

puts "2/6- Cleaning the Locataire DB..."
Locataire.destroy_all

puts "3/6 - Cleaning the Depense DB..."
Depense.destroy_all

puts "4/6 - Cleaning the Frais_recurrent DB..."
FraisRecurrent.destroy_all

puts "5/6 - Cleaning the Bien DB..."
Bien.destroy_all

puts "6/6 - Cleaning the User DB..."
User.destroy_all

puts "~ All DB cleaned up"
puts "//////////////////////////////////////////////////////"



##########################################################################
# Creating process

puts "//////////////////////////////////////////////////////"
puts "Starting the seeding process..."


## - # - ###########################################################################
# User
puts "1/6 - Seeding the User DB..."

queen_elizabeth = User.new({
    prenom: "Elizabeth",
    nom: "Windsor",
    email: "julie.laloy@gmail.com",
    num_tel: "0614514502",
    password: "123456"
})
queen_elizabeth.save


## - # - ###########################################################################
# Bien
puts "2/6 - Seeding the Bien DB..."

# Bien 1
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


# Bien 2
chateau_de_sedieres = Bien.new({
    nom: "Château de Sédières - Clergoux",
    categorie: "Maison",
    adresse: "sedières",
    ville: "Clergoux",
    code_postal: "19320",
    pays: "France",
    info_compl_adresse: "Parc Arboré",
    surface: "320",
    nb_pieces: "7",
    nb_sdb: "3",
    nb_etages: "3",
    num_etage: "0",
    annee_construction: "01/01/1780",
    prix_acquisition: "670000",
    date_acquisition: "01/01/2011",
    frais_achat_notaire: "17000",
    frais_achat_agence: "30000",
    frais_achat_travaux: "250000",
    frais_achat_autres: "1500"
})

chateau_de_sedieres.user = queen_elizabeth
chateau_de_sedieres.save


# Bien 3
maison_lignerac = Bien.new({
    nom: "Maison Lignerac - Clergoux",
    categorie: "Maison",
    adresse: "Le bourg",
    ville: "lignerac",
    code_postal: "19500",
    pays: "France",
    info_compl_adresse: "A seulement 15 min de Brive se trouve cette belle grange rénovée avec goût et des matériaux de qualité. En situation dominante, sur plus de 2 ha de terrain, elle vous offre le confort d'une maison moderne à l'intérieur et le charme des vielles pierres à l'extérieur. Le Rez de chaussée se compose d'un séjour de 85m² avec sa cuisine ouverte, une suite parentale avec salle de bain. Très lumineux grâce à des baies vitrées ouvertes sur la terrasse et le jardin.",
    surface: "185",
    nb_pieces: "5",
    nb_sdb: "2",
    nb_etages: "1",
    num_etage: "0",
    annee_construction: "01/01/1780",
    prix_acquisition: "450000",
    date_acquisition: "01/01/2011",
    frais_achat_notaire: "20000",
    frais_achat_agence: "22500",
    frais_achat_travaux: "5000",
    frais_achat_autres: "1750"
})

maison_lignerac.user = queen_elizabeth
maison_lignerac.save

# Bien 4
villa_stprivat = Bien.new({
    nom: "Villa - Saint Privat",
    categorie: "Maison",
    adresse: "Le bourg",
    ville: "saint-privat",
    code_postal: "19320",
    pays: "France",
    info_compl_adresse: "Au coeur d'un village historique de la Corrèze, cette maison unique avec un jardin magnifiquement aménagé et une piscine intérieure est à vendre. La résidence date du XIXe siècle, mais elle a été entièrement rénovée en 2009 et a été achevée et restaurée à la perfection. ",
    surface: "406",
    nb_pieces: "10",
    nb_sdb: "3",
    nb_etages: "1",
    num_etage: "0",
    annee_construction: "01/01/1880",
    prix_acquisition: "407500",
    date_acquisition: "01/01/2019",
    frais_achat_notaire: "12000",
    frais_achat_agence: "20500",
    frais_achat_travaux: "3000",
    frais_achat_autres: "1850"
})

villa_stprivat.user = queen_elizabeth
villa_stprivat.save


## - # - ###########################################################################
# Frais recurrents
puts "3/6 - Seeding the Frais recurrents DB..."

# Frais recurents
emprunt_bpec = FraisRecurrent.new({
    nom: "Prêt amortissable",
    montant: "170500",
    categorie: "Crédit"
    recurrence: "Mensuel",
    date_debut: "01/01/2010",
    date_fin: "01/01/2030"
})

emprunt_bpec.bien = buckingham_palace_en_correze
emprunt_bpec.save


taxe_fonciere_bpec = FraisRecurrent.new({
    nom: "Taxe foncière",
    montant: "2000",
    categorie: "Taxe Foncière"
    recurrence: "Annuel",
    date_debut: "01/01/2010",
    date_fin: "01/01/2099"
})

taxe_fonciere_bpec.bien = buckingham_palace_en_correze
taxe_fonciere_bpec.save

charges_bpec = FraisRecurrent.new({
    nom: "Charges",
    montant: "600",
    categorie: "Copropriété"
    recurrence: "Annuel",
    date_debut: "01/01/2010",
    date_fin: "01/01/2099"
})

charges_bpec.bien = buckingham_palace_en_correze
charges_bpec.save

assurance_bpec = FraisRecurrent.new({
    nom: "Assurance PNO",
    montant: "200",
    categorie: "Assurances"
    recurrence: "Annuel",
    date_debut: "01/01/2010",
    date_fin: "01/01/2099"
})

assurance_bpec.bien = buckingham_palace_en_correze
assurance_bpec.save


## - # - ###########################################################################
# Depenses
puts "4/6 - Seeding the Depenses DB..."

# Depenses 1
travaux_bal = Depense.new({
    nom: "Travaux boîte aux lettres",
    montant: "200",
    date_paiement: "01/02/2021"
})

travaux_bal.bien = buckingham_palace_en_correze
travaux_bal.save

travaux_sdb = Depense.new({
    nom: "Travaux salle de bain",
    montant: "2500",
    date_paiement: "01/06/2020"
})

travaux_sdb.bien = buckingham_palace_en_correze
travaux_sdb.save

# Depenses 2
pompe_chaleur = Depense.new({
    nom: "Pompe à chaleur",
    montant: "15000",
    date_paiement: "01/04/2021"
})

pompe_chaleur.bien = chateau_de_sedieres
pompe_chaleur.save

# Depenses 3
travaux_bal = Depense.new({
    nom: "Entretien des jardins",
    montant: "1200",
    date_paiement: "01/03/2020"
})

travaux_bal.bien = maison_lignerac
travaux_bal.save

# Depenses 4
travaux_bal = Depense.new({
    nom: "Révision climatisation",
    montant: "180",
    date_paiement: "01/06/2020"
})

travaux_bal.bien = villa_stprivat
travaux_bal.save


## - # - ###########################################################################
# Locataire
puts "5/6 - Seeding the Locataires DB..."

# Locataire 1
françois_hollande = Locataire.new({
    prenom: "François",
    nom: "Hollande",
    email: "julie.laloy@gmail.com",
    num_tel: "0614514503",
    adresse: "Avenue Montaigne",
    ville: "Paris",
    code_postal: "75008",
    pays: "France",
    date_debut_location: "01/01/2020"
})
françois_hollande.bien = buckingham_palace_en_correze
françois_hollande.save

# Locataire 2
laeticia_halliday = Locataire.new({
    prenom: "Laetitia",
    nom: "Halliday",
    email: "julie.laloy@gmail.com",
    num_tel: "0614514503",
    adresse: "45 Avenue Montaigne",
    ville: "Paris",
    code_postal: "75008",
    pays: "France",
    date_debut_location: "01/01/2020"
})
laeticia_halliday.bien = chateau_de_sedieres
laeticia_halliday.save

# Locataire 3

julien_dore = Locataire.new({
    prenom: "Julien",
    nom: "Doré",
    email: "julie.laloy@gmail.com",
    num_tel: "0614514503",
    adresse: "8 rue Danielle Casanova",
    ville: "Paris",
    code_postal: "75002",
    pays: "France",
    date_debut_location: "01/01/2022"
})
julien_dore.bien = maison_lignerac
julien_dore.save


## - # - ###########################################################################
# Loyers
puts "6/6 - Seeding the Loyers DB..."

# Loyers - locataire 1
loyer_20210101 = Loyer.new({
    montant: "500",
    date_paiement: "01/01/2021"
})
loyer_20210101.bien = buckingham_palace_en_correze
loyer_20210101.locataire = françois_hollande
loyer_20210101.save

loyer_20210201 = Loyer.new({
    montant: "500",
    date_paiement: "01/02/2021"
})
loyer_20210201.bien = buckingham_palace_en_correze
loyer_20210201.locataire = françois_hollande
loyer_20210201.save

loyer_20210301 = Loyer.new({
    montant: "500",
    date_paiement: "01/03/2021"
})
loyer_20210301.bien = buckingham_palace_en_correze
loyer_20210301.locataire = françois_hollande
loyer_20210301.save

# Loyers - locataire 2
loyer_20210101 = Loyer.new({
    montant: "1200",
    date_paiement: "01/01/2021"
})
loyer_20210101.bien = chateau_de_sedieres
loyer_20210101.locataire = laeticia_halliday
loyer_20210101.save

loyer_20210201 = Loyer.new({
    montant: "1200",
    date_paiement: "01/02/2021"
})
loyer_20210201.bien = chateau_de_sedieres
loyer_20210201.locataire = laeticia_halliday
loyer_20210201.save

loyer_20210301 = Loyer.new({
    montant: "1200",
    date_paiement: "01/03/2021"
})
loyer_20210301.bien = chateau_de_sedieres
loyer_20210301.locataire = laeticia_halliday
loyer_20210301.save


# Loyers - locataire 3
loyer_20210101 = Loyer.new({
    montant: "990",
    date_paiement: "01/01/2021"
})
loyer_20210101.bien = maison_lignerac
loyer_20210101.locataire = julien_dore
loyer_20210101.save

loyer_20210201 = Loyer.new({
    montant: "990",
    date_paiement: "01/02/2021"
})
loyer_20210201.bien = maison_lignerac
loyer_20210201.locataire = julien_dore
loyer_20210201.save

loyer_20210301 = Loyer.new({
    montant: "990",
    date_paiement: "01/03/2021"
})
loyer_20210301.bien = maison_lignerac
loyer_20210301.locataire = julien_dore
loyer_20210301.save

puts "~ All seeds created: 
- #{User.all.count} users
- #{Bien.all.count} biens
- #{FraisRecurrent.all.count} frais recurrents
- #{Depense.all.count} depenses
- #{Locataire.all.count} locataires
- #{Loyer.all.count} loyers"
puts "//////////////////////////////////////////////////////"