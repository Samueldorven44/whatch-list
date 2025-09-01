# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "🧹 Cleaning database..."
List.destroy_all
User.destroy_all


require 'bcrypt'

# Création d'un user de seed
User.create!(
  firstname: "Jean",
  lastname: "Dupont",
  email: "jean.dupont@example.com",
  password: "password123", # Devise gère le hash automatiquement via `has_secure_password`
  password_confirmation: "password123"
)

puts "✅ Seed user créé avec succès !"
