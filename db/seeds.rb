# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Idea.create(
            name: "Open Idea Station",
            description: "This is the OIS base application built with Ruby on Rails",
            author: "Dinobi",
            organization: "OIS"
            )

Idea.create(
            name: "Quadnate",
            description: "4 spaces of cordination",
            author: "Dinobi",
            organization: "Quadnate"
            )

User.create(
            username: "Dinobi",
            email: "dinobi.kenkwo@andela.com",
            password: "DinoAcorn45"
            )
            