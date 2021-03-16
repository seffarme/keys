# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_15_142246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "biens", force: :cascade do |t|
    t.string "nom"
    t.string "type"
    t.string "adresse"
    t.string "ville"
    t.integer "code_postal"
    t.string "pays"
    t.string "info_comp_adresse"
    t.integer "surface"
    t.integer "nb_pieces"
    t.integer "nb_sdb"
    t.integer "num_etage"
    t.integer "nb_etages"
    t.integer "annee_construction"
    t.integer "prix_acquisition"
    t.date "date_acquisition"
    t.integer "frais_achat_notaire"
    t.integer "frais_achat_agence"
    t.integer "frais_achat_travaux"
    t.integer "frais_achat_autres"
    t.bigint "proprietaire_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["proprietaire_id"], name: "index_biens_on_proprietaire_id"
  end

  create_table "depenses", force: :cascade do |t|
    t.string "nom"
    t.integer "montant"
    t.date "date_paiement"
    t.bigint "bien_id", null: false
    t.bigint "frais_recurrent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bien_id"], name: "index_depenses_on_bien_id"
    t.index ["frais_recurrent_id"], name: "index_depenses_on_frais_recurrent_id"
  end

  create_table "frais_recurrents", force: :cascade do |t|
    t.string "nom"
    t.integer "montant"
    t.string "recurrence"
    t.date "date_fin"
    t.bigint "bien_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bien_id"], name: "index_frais_recurrents_on_bien_id"
  end

  create_table "locataires", force: :cascade do |t|
    t.string "prenom"
    t.string "nom"
    t.string "email"
    t.integer "num_tel"
    t.string "adresse"
    t.string "ville"
    t.integer "code_postal"
    t.string "pays"
    t.date "date_debut_location"
    t.bigint "bien_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bien_id"], name: "index_locataires_on_bien_id"
  end

  create_table "loyers", force: :cascade do |t|
    t.integer "montant"
    t.date "date_paiement"
    t.bigint "bien_id", null: false
    t.bigint "locataire_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bien_id"], name: "index_loyers_on_bien_id"
    t.index ["locataire_id"], name: "index_loyers_on_locataire_id"
  end

  create_table "proprietaires", force: :cascade do |t|
    t.string "prenom"
    t.string "nom"
    t.string "email"
    t.integer "num_tel"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "biens", "proprietaires"
  add_foreign_key "depenses", "biens"
  add_foreign_key "depenses", "frais_recurrents"
  add_foreign_key "frais_recurrents", "biens"
  add_foreign_key "locataires", "biens"
  add_foreign_key "loyers", "biens"
  add_foreign_key "loyers", "locataires"
end
