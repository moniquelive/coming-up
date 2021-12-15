# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create twitch_name: "Primeirona"
user.save!

idea1 = Idea.create title: "Um novo e belo título 2",
                    body:  "Com direito a emoji e tutto.... 🌼",
                    user:  user
idea1.save!
idea2 = Idea.create title: "Chique",
                    body:  "body++",
                    user:  user
idea2.save!
idea3 = Idea.create title: "Demais",
                    body:  "oi oi",
                    user:  user
idea3.save!
idea4 = Idea.create title: "Mais unzinho...",
                    body:  "Só pra ver se quebra a linha...",
                    user:  user
idea4.save!

Star.create! user: user, idea: idea1
Star.create! user: user, idea: idea2
Star.create! user: user, idea: idea2
Star.create! user: user, idea: idea3
Star.create! user: user, idea: idea4
