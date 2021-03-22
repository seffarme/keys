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

puts "[1/6] - Cleaning the Loyer DB..."
Loyer.destroy_all

puts "[2/6] - Cleaning the Locataire DB..."
Locataire.destroy_all

puts "[3/6] - Cleaning the Depense DB..."
Depense.destroy_all

puts "[4/6] - Cleaning the Frais_recurrent DB..."
FraisRecurrent.destroy_all

puts "[5/6] - Cleaning the Bien DB..."
Bien.destroy_all

puts "[6/6] - Cleaning the User DB..."
User.destroy_all

puts "~ All DB cleaned up
"
puts "//////////////////////////////////////////////////////"



##########################################################################
# Creating process

puts "//////////////////////////////////////////////////////"
puts "Starting the seeding process..."


## - # - ###########################################################################
# User
puts "[1/6] - Seeding the User DB..."

mathieu_eustachy = User.new({
    prenom: "Mathieu",
    nom: "Eustachy",
    email: "mathieu.eustachy@gmail.com",
    num_tel: "0614714703",
    password: "123456",
    admin: true
})
mathieu_eustachy.save


## - # - ###########################################################################
# Bien
puts "[2/6] - Seeding the Bien DB..."

# Bien 1
appartement_pigalle = Bien.new({
    nom: "Appartement Pigalle",
    categorie: "Appartement",
    adresse: "69, rue Jean-Baptiste Pigalle",
    ville: "Paris IX",
    code_postal: "75009",
    pays: "France",
    info_compl_adresse: "Très bel appartement avec vue sur la place Pigalle",
    surface: "31",
    nb_pieces: "1",
    nb_sdb: "1",
    nb_etages: "6",
    num_etage: "4",
    annee_construction: "15/06/1970",
    prix_acquisition: "325000",
    date_acquisition: "01/01/2018",
    frais_achat_notaire: "25000",
    frais_achat_agence: "10000",
    frais_achat_travaux: "5000",
    frais_achat_autres: "2500",
    montant_loyer: "950"
})

appartement_pigalle.user = mathieu_eustachy
appartement_pigalle.save


# Bien 2
appartement_rue_des_dames = Bien.new({
    nom: "Appartement rue des Dames",
    categorie: "Appartement",
    adresse: "106, rue des Dames",
    ville: "Paris XVII",
    code_postal: "75017",
    pays: "France",
    info_compl_adresse: "Joli appartement dans une rue animée",
    surface: "27",
    nb_pieces: "2",
    nb_sdb: "1",
    nb_etages: "3",
    num_etage: "5",
    annee_construction: "01/04/1983",
    prix_acquisition: "250000",
    date_acquisition: "15/06/2015",
    frais_achat_notaire: "20000",
    frais_achat_agence: "0",
    frais_achat_travaux: "3500",
    frais_achat_autres: "1500",
    montant_loyer: "800"
})

appartement_rue_des_dames.user = mathieu_eustachy
appartement_rue_des_dames.save


# Bien 3
maison_gennevilliers = Bien.new({
    nom: "Maison Gennevilliers",
    categorie: "Maison",
    adresse: "17, rue de l'arbre sec",
    ville: "Gennevilliers",
    code_postal: "92230",
    pays: "France",
    info_compl_adresse: "Petite maison dans une allée résidentielle. Mon premier investissement locatif !",
    surface: "125",
    nb_pieces: "5",
    nb_sdb: "2",
    nb_etages: "1",
    num_etage: "0",
    annee_construction: "01/01/2001",
    prix_acquisition: "400000",
    date_acquisition: "01/01/2001",
    frais_achat_notaire: "30000",
    frais_achat_agence: "15000",
    frais_achat_travaux: "5000",
    frais_achat_autres: "12500",
    montant_loyer: "2500"
})

maison_gennevilliers.user = mathieu_eustachy
maison_gennevilliers.save

# Bien 4
appartement_clichy = Bien.new({
    nom: "Appartement Clichy",
    categorie: "Appartement",
    adresse: "100, rue Martre",
    ville: "Clichy",
    code_postal: "92110",
    pays: "France",
    info_compl_adresse: "Appartement juste au-dessus du Monoprix",
    surface: "80",
    nb_pieces: "4",
    nb_sdb: "1",
    nb_etages: "6",
    num_etage: "5",
    annee_construction: "12/01/1990",
    prix_acquisition: "450000",
    date_acquisition: "01/07/2012",
    frais_achat_notaire: "35000",
    frais_achat_agence: "20000",
    frais_achat_travaux: "35000",
    frais_achat_autres: "12500",
    montant_loyer: "2200"
})

appartement_clichy.user = mathieu_eustachy
appartement_clichy.save


## - # - ###########################################################################
# Frais recurrents
puts "[3/6] - Seeding the Frais recurrents DB..."

################### Appartement Pigalle ##################
# Emprunt
emprunt_pigalle = FraisRecurrent.new({
    nom: "Prêt amortissable sur 20 ans",
    montant: "1500",
    categorie: "Crédit",
    recurrence: "Mensuel",
    date_debut: "01/01/2018",
    date_fin: "01/01/2038"
})

emprunt_pigalle.bien = appartement_pigalle
emprunt_pigalle.save
emprunt_pigalle.populate_depenses(appartement_pigalle)

# Taxe foncière
taxe_fonciere_pigalle = FraisRecurrent.new({
    nom: "Taxe foncière",
    montant: "2000",
    categorie: "Taxe Foncière",
    recurrence: "Annuel",
    date_debut: "05/10/2018",
    date_fin: "05/10/2050"
})

taxe_fonciere_pigalle.bien = appartement_pigalle
taxe_fonciere_pigalle.save
taxe_fonciere_pigalle.populate_depenses(appartement_pigalle)

# Charges
charges_pigalle = FraisRecurrent.new({
    nom: "Charges",
    montant: "85",
    categorie: "Copropriété",
    recurrence: "Mensuel",
    date_debut: "01/12/2018",
    date_fin: "01/12/2050"
})

charges_pigalle.bien = appartement_pigalle
charges_pigalle.save
charges_pigalle.populate_depenses(appartement_pigalle)

# Assurances 
assurance_pno_pigalle = FraisRecurrent.new({
    nom: "Assurance PNO",
    montant: "15",
    categorie: "Assurances",
    recurrence: "Mensuel",
    date_debut: "05/01/2018",
    date_fin: "05/01/2050"
})

assurance_pno_pigalle.bien = appartement_pigalle
assurance_pno_pigalle.save
assurance_pno_pigalle.populate_depenses(appartement_pigalle)

assurance_gli_pigalle = FraisRecurrent.new({
    nom: "Assurance Loyers Impayés",
    montant: "30",
    categorie: "Assurances",
    recurrence: "Mensuel",
    date_debut: "05/01/2018",
    date_fin: "05/01/2050"
})

assurance_gli_pigalle.bien = appartement_pigalle
assurance_gli_pigalle.save
assurance_gli_pigalle.populate_depenses(appartement_pigalle)



################### Appartement Rue des Dames ##################

emprunt_ruedesdames = FraisRecurrent.new({
    nom: "Prêt amortissable sur 20 ans",
    montant: "1125",
    categorie: "Crédit",
    recurrence: "Mensuel",
    date_debut: "15/06/2015",
    date_fin: "15/06/2035"
})

emprunt_ruedesdames.bien = appartement_rue_des_dames
emprunt_ruedesdames.save
emprunt_ruedesdames.populate_depenses(appartement_rue_des_dames)

# Taxe foncière
taxe_fonciere_ruedesdames = FraisRecurrent.new({
    nom: "Taxe foncière",
    montant: "1560",
    categorie: "Taxe Foncière",
    recurrence: "Annuel",
    date_debut: "05/10/2018",
    date_fin: "05/10/2050"
})

taxe_fonciere_ruedesdames.bien = appartement_rue_des_dames
taxe_fonciere_ruedesdames.save
taxe_fonciere_ruedesdames.populate_depenses(appartement_rue_des_dames)

# Charges
charges_ruedesdames = FraisRecurrent.new({
    nom: "Charges",
    montant: "70",
    categorie: "Copropriété",
    recurrence: "Mensuel",
    date_debut: "15/06/2015",
    date_fin: "15/06/2050"
})

charges_ruedesdames.bien = appartement_rue_des_dames
charges_ruedesdames.save
charges_ruedesdames.populate_depenses(appartement_rue_des_dames)

# Assurances 
assurance_pno_ruedesdames = FraisRecurrent.new({
    nom: "Assurance PNO",
    montant: "15",
    categorie: "Assurances",
    recurrence: "Mensuel",
    date_debut: "15/06/2015",
    date_fin: "15/06/2050"
})

assurance_pno_ruedesdames.bien = appartement_rue_des_dames
assurance_pno_ruedesdames.save
assurance_pno_ruedesdames.populate_depenses(appartement_rue_des_dames)

assurance_gli_ruedesdames = FraisRecurrent.new({
    nom: "Assurance Loyers Impayés",
    montant: "25",
    categorie: "Assurances",
    recurrence: "Mensuel",
    date_debut: "15/06/2015",
    date_fin: "15/06/2050"
})

assurance_gli_ruedesdames.bien = appartement_rue_des_dames
assurance_gli_ruedesdames.save
assurance_gli_ruedesdames.populate_depenses(appartement_rue_des_dames)




################### Maison Gennevilliers ##################

emprunt_maisongennevilliers = FraisRecurrent.new({
    nom: "Prêt amortissable sur 15 ans",
    montant: "2500",
    categorie: "Crédit",
    recurrence: "Mensuel",
    date_debut: "01/01/2001",
    date_fin: "01/01/2016"
})

emprunt_maisongennevilliers.bien = maison_gennevilliers
emprunt_maisongennevilliers.save
emprunt_maisongennevilliers.populate_depenses(maison_gennevilliers)

# Taxe foncière
taxe_fonciere_maisongennevilliers = FraisRecurrent.new({
    nom: "Taxe foncière",
    montant: "4500",
    categorie: "Taxe Foncière",
    recurrence: "Annuel",
    date_debut: "05/10/2001",
    date_fin: "05/10/2050"
})

taxe_fonciere_maisongennevilliers.bien = maison_gennevilliers
taxe_fonciere_maisongennevilliers.save
taxe_fonciere_maisongennevilliers.populate_depenses(maison_gennevilliers)

# Assurances 
assurance_pno_maisongennevilliers = FraisRecurrent.new({
    nom: "Assurance PNO",
    montant: "60",
    categorie: "Assurances",
    recurrence: "Mensuel",
    date_debut: "01/03/2001",
    date_fin: "01/03/2050"
})

assurance_pno_maisongennevilliers.bien = maison_gennevilliers
assurance_pno_maisongennevilliers.save
assurance_pno_maisongennevilliers.populate_depenses(maison_gennevilliers)

assurance_gli_maisongennevilliers = FraisRecurrent.new({
    nom: "Assurance Loyers Impayés",
    montant: "90",
    categorie: "Assurances",
    recurrence: "Mensuel",
    date_debut: "01/03/2001",
    date_fin: "01/03/2050"
})

assurance_gli_maisongennevilliers.bien = maison_gennevilliers
assurance_gli_maisongennevilliers.save
assurance_gli_maisongennevilliers.populate_depenses(maison_gennevilliers)



################### Appartement Clichy ##################

emprunt_clichy = FraisRecurrent.new({
    nom: "Prêt amortissable sur 20 ans",
    montant: "2150",
    categorie: "Crédit",
    recurrence: "Mensuel",
    date_debut: "01/07/2012",
    date_fin: "01/07/2032"
})

emprunt_clichy.bien = appartement_clichy
emprunt_clichy.save
emprunt_clichy.populate_depenses(appartement_clichy)

# Taxe foncière
taxe_fonciere_clichy = FraisRecurrent.new({
    nom: "Taxe foncière",
    montant: "5000",
    categorie: "Taxe Foncière",
    recurrence: "Annuel",
    date_debut: "05/10/2012",
    date_fin: "05/10/2050"
})

taxe_fonciere_clichy.bien = appartement_clichy
taxe_fonciere_clichy.save
taxe_fonciere_clichy.populate_depenses(appartement_clichy)

# Charges
charges_clichy = FraisRecurrent.new({
    nom: "Charges",
    montant: "120",
    categorie: "Copropriété",
    recurrence: "Mensuel",
    date_debut: "01/07/2012",
    date_fin: "15/06/2050"
})

charges_clichy.bien = appartement_clichy
charges_clichy.save
charges_clichy.populate_depenses(appartement_clichy)

# Assurances 
assurance_pno_clichy = FraisRecurrent.new({
    nom: "Assurance PNO",
    montant: "35",
    categorie: "Assurances",
    recurrence: "Mensuel",
    date_debut: "01/07/2012",
    date_fin: "01/07/2050"
})

assurance_pno_clichy.bien = appartement_clichy
assurance_pno_clichy.save
assurance_pno_clichy.populate_depenses(appartement_clichy)

assurance_gli_clichy = FraisRecurrent.new({
    nom: "Assurance Loyers Impayés",
    montant: "70",
    categorie: "Assurances",
    recurrence: "Mensuel",
    date_debut: "01/07/2012",
    date_fin: "01/07/2050"
})

assurance_gli_clichy.bien = appartement_clichy
assurance_gli_clichy.save
assurance_gli_clichy.populate_depenses(appartement_clichy)

## - # - ###########################################################################
# Depenses
puts "[4/6] - Seeding the Depenses DB..."

################### Appartement Pigalle ##################
# Depense 1
travaux_bal = Depense.new({
    nom: "Travaux boîte aux lettres",
    montant: "200",
    categorie: "Travaux",
    date_paiement: "01/07/2020"
})
travaux_bal.bien = appartement_pigalle
travaux_bal.save

# Depense 2
travaux_sdb = Depense.new({
    nom: "Travaux salle de bain",
    montant: "2500",
    categorie: "Travaux",
    date_paiement: "01/02/2021"
})
travaux_sdb.bien = appartement_pigalle
travaux_sdb.save


################### Appartement Rue des dames ##################
# Depense 1
peinture_ruedesdames = Depense.new({
    nom: "Rafraichissement du salon (peinture)",
    montant: "200",
    categorie: "Travaux",
    date_paiement: "12/09/2020"
})
peinture_ruedesdames.bien = appartement_rue_des_dames
peinture_ruedesdames.save

# Depense 2
reparation_ascenseur_ruedesdames = Depense.new({
    nom: "Réparation de l'ascenseur",
    montant: "653",
    categorie: "Copropriété",
    date_paiement: "22/02/2021"
})
reparation_ascenseur_ruedesdames.bien = appartement_rue_des_dames
reparation_ascenseur_ruedesdames.save

# Depense 3
achat_lampesalon_appartementruedesdames = Depense.new({
    nom: "Achat nouvelle lampe du salon",
    montant: "34.99",
    categorie: "Autres",
    date_paiement: "24/12/2020"
})
achat_lampesalon_appartementruedesdames.bien = appartement_rue_des_dames
achat_lampesalon_appartementruedesdames.save


################### Maison Gennevilliers ##################
# Depense 1
pompe_chaleur_maisongennevilliers = Depense.new({
    nom: "Réparation pompe à chaleur",
    montant: "15000",
    categorie: "Travaux",
    date_paiement: "01/03/2021"
})
pompe_chaleur_maisongennevilliers.bien = maison_gennevilliers
pompe_chaleur_maisongennevilliers.save

# Depense 2
entretien_jardin_maisongennevilliers = Depense.new({
    nom: "Entretien des jardins",
    montant: "1200",
    categorie: "Autres",
    date_paiement: "01/10/2020"
})
entretien_jardin_maisongennevilliers.bien = maison_gennevilliers
entretien_jardin_maisongennevilliers.save

# Depenses 3
revision_climatisation_maisongennevilliers = Depense.new({
    nom: "Révision climatisation",
    montant: "180",
    categorie: "Travaux",
    date_paiement: "01/06/2016"
})
revision_climatisation_maisongennevilliers.bien = maison_gennevilliers
revision_climatisation_maisongennevilliers.save


################### Appartement Clichy ##################
# Depense 1
achat_table_basse_appartementclichy = Depense.new({
    nom: "Achat table basse neuve",
    montant: "89.99",
    categorie: "Autres",
    date_paiement: "24/12/2020"
})
achat_table_basse_appartementclichy.bien = appartement_clichy
achat_table_basse_appartementclichy.save

# Depense 2
ravalementfacade_appartementclichy = Depense.new({
    nom: "Ravalement de façade",
    montant: "12500",
    categorie: "Copropriété",
    date_paiement: "01/05/2020"
})
ravalementfacade_appartementclichy.bien = appartement_clichy
ravalementfacade_appartementclichy.save


## - # - ###########################################################################
# Locataire
puts "[5/6] - Seeding the Locataires DB..."

# Locataire Pigalle
diane_garcia = Locataire.new({
    prenom: "Diane",
    nom: "Garcia",
    email: "diane.garcia@gmail.com",
    num_tel: "0614514503",
    adresse: "Capitole",
    ville: "Toulouse",
    code_postal: "31000",
    pays: "France",
    date_debut_location: "01/01/2018"
})
diane_garcia.bien = appartement_pigalle
diane_garcia.save

# Locataire 2 Rue des Dames
mathilde_reynes = Locataire.new({
    prenom: "Mathilde",
    nom: "Reynes",
    email: "mathilde.reynes@outlook.com",
    num_tel: "0756328745",
    adresse: "Capitole",
    ville: "Toulouse",
    code_postal: "31000",
    pays: "France",
    date_debut_location: "15/06/2015"
})
mathilde_reynes.bien = appartement_rue_des_dames
mathilde_reynes.save

# Locataire 3 Maison Gennevilliers
othman_igrouche = Locataire.new({
    prenom: "Othman",
    nom: "Igrouche",
    email: "othman.igrouche@gmail.com",
    num_tel: "0654238709",
    adresse: "Gauthier",
    ville: "Casablanca",
    code_postal: "20xx0",
    pays: "Maroc",
    date_debut_location: "01/01/2019"
})
othman_igrouche.bien = maison_gennevilliers
othman_igrouche.save

# Locataire 4
thierno_ba = Locataire.new({
    prenom: "Thierno",
    nom: "Ba",
    email: "thierno.ba@gmail.com",
    num_tel: "0614514507",
    adresse: "15, place des Terreaux",
    ville: "Lyon",
    code_postal: "69001",
    pays: "France",
    date_debut_location: "01/01/2020"
})
thierno_ba.bien = appartement_clichy
thierno_ba.save

## - # - ###########################################################################
# Loyers
puts "[6/6] - Seeding the Loyers DB..."


################### Appartement Pigalle ##################

# 2020
12.times do |i, loyer|
    loyer = Loyer.new({
        montant: appartement_pigalle.montant_loyer,
        date_paiement: "01/0#{i}/2020"
    })
    i += 1
    loyer.bien = appartement_pigalle
    loyer.locataire = diane_garcia
    loyer.save
end

# 2021
4.times do |i, loyer| 
    loyer = Loyer.new({
        montant: appartement_pigalle.montant_loyer,
        date_paiement: "01/0#{i}/2021"
    })
    i += 1
    loyer.bien = appartement_pigalle
    loyer.locataire = diane_garcia
    loyer.save
end


################### Appartement Rue des Dames ##################

# 2020
12.times do |i, loyer|
    loyer = Loyer.new({
        montant: appartement_rue_des_dames.montant_loyer,
        date_paiement: "01/0#{i}/2020"
    })
    i += 1
    loyer.bien = appartement_rue_des_dames
    loyer.locataire = mathilde_reynes
    loyer.save
end

# 2021
4.times do |i, loyer| 
    loyer = Loyer.new({
        montant: appartement_rue_des_dames.montant_loyer,
        date_paiement: "01/0#{i}/2021"
    })
    i += 1
    loyer.bien = appartement_rue_des_dames
    loyer.locataire = mathilde_reynes
    loyer.save
end

################### Maison Gennevilliers ##################

# 2020
12.times do |i, loyer|
    loyer = Loyer.new({
        montant: maison_gennevilliers.montant_loyer,
        date_paiement: "01/0#{i}/2020"
    })
    i += 1
    loyer.bien = maison_gennevilliers
    loyer.locataire = othman_igrouche
    loyer.save
end

# 2021
4.times do |i, loyer| 
    loyer = Loyer.new({
        montant: maison_gennevilliers.montant_loyer,
        date_paiement: "01/0#{i}/2021"
    })
    i += 1
    loyer.bien = maison_gennevilliers
    loyer.locataire = othman_igrouche
    loyer.save
end

################### Appartement Clichy ##################

# 2020
12.times do |i, loyer|
    loyer = Loyer.new({
        montant: appartement_clichy.montant_loyer,
        date_paiement: "01/0#{i}/2020"
    })
    i += 1
    loyer.bien = appartement_clichy
    loyer.locataire = thierno_ba
    loyer.save
end

# 2021
4.times do |i, loyer| 
    loyer = Loyer.new({
        montant: appartement_clichy.montant_loyer,
        date_paiement: "01/0#{i}/2021"
    })
    i += 1
    loyer.bien = appartement_clichy
    loyer.locataire = thierno_ba
    loyer.save
end


puts "
~ All seeds created: 
- #{User.all.count} users
- #{Bien.all.count} biens
- #{FraisRecurrent.all.count} frais recurrents
- #{Depense.all.count} depenses
- #{Locataire.all.count} locataires
- #{Loyer.all.count} loyers
"
puts "//////////////////////////////////////////////////////"