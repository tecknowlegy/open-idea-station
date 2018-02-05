# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ideas_list = [
  [ "Open Idea Station", "This is the OIS base application built with Ruby on Rails", "Dinobi", "OIS" ],
  [ "Quadnate", "4 spaces of cordination", "Dinobi", "OIS" ],
  [ "Happy Helpers", "A code description of how methods should be named in ruby", "Dinobi", "OIS" ],
  [ "PostIt", "A group messaging app", "Dinobi", "Andela" ],
  [ "PosticoDB", "An open source database system", "Adam", "Postico" ],
  [ "Paale", "Connect with loved ones", "Philip", "PJN-LLC" ],
  [ "Cookerel", "Food as a service", "Dinobi", "OIS" ],
  [ "SportyVite", "Know what your favourite sportman is listening to in realtime", "Dinobi", "OIS" ],

]

ideas_list.each do |name, description, author, organization|
  Idea.create(
                  name: name,
                  description: description,
                  author: author,
                  organization: organization
                )
end


# Idea.create(
#             name: "Open Idea Station",
#             description: "This is the OIS base application built with Ruby on Rails",
#             author: "Dinobi",
#             organization: "OIS"
#             )

# Idea.create(
#             name: "Quadnate",
#             description: "4 spaces of cordination",
#             author: "Dinobi",
#             organization: "Quadnate"
#             )

User.create(
            username: "Dinobi",
            email: "dinobi.kenkwo@andela.com",
            password: "DinoAcorn45"
            )
            