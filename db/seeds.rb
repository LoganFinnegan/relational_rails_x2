# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
@wizard_1 = Wizard.create!(name: "Larry", level: 5, graduated: true, age: 200)
@wizard_2 = Wizard.create!(name: "Logan", level: 7, graduated: true, age: 211)

@spell_2 = @wizard_1.spells.create!(name: "Haste", learned: true, spell_level: 3)
@spell_1 = @wizard_1.spells.create!(name: "Fireball", learned: true, spell_level: 3)
