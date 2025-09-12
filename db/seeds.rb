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
Movie.destroy_all


require 'bcrypt'

# Création d'un user de seed
User.create!(
  firstname: "Jean",
  lastname: "Dupont",
  email: "jean.dupont@example.com",
  password: "password123", # Devise gère le hash automatiquement via `has_secure_password`
  password_confirmation: "password123",
  age: 20,
  phone_number: "06 35 67 89 10",
)

movies = [
  {
    name: "The Godfather",
    description: "The Godfather is more than a gangster film; it is an intricate exploration of power, family, tradition, and transformation. Set in the aftermath of World War II, it chronicles the life of the Corleone family, an Italian-American mafia dynasty navigating loyalty and betrayal in a shifting America. As the aging Don Vito Corleone attempts to pass on the reins of the empire to his reluctant son Michael, we witness a chilling metamorphosis. Michael, initially a war hero detached from the family's criminal world, is gradually pulled into its dark underbelly. What begins as a family saga slowly unravels into a tragedy about the seductive and corrosive nature of power. With unforgettable performances and hauntingly beautiful cinematography, The Godfather redefined the crime genre and remains a towering achievement in storytelling.",
    mini_description: "A family. A business. A legend.",
    poster_url: "movies/the_godfather.jpg",
    tmdb_id: 238
  },
  {
    name: "The Shawshank Redemption",
    description: "Set inside the cold stone walls of Shawshank State Penitentiary, this is a story of unbreakable hope in the face of institutional despair. Andy Dufresne, a quiet, intelligent banker convicted for a crime he didn’t commit, learns to endure the brutal realities of prison life while maintaining an inner world of purpose and dignity. Over two decades, he forms a deep friendship with Ellis 'Red' Redding, a fellow inmate who becomes both narrator and moral compass. As time passes, Andy secretly works toward a stunning escape plan that will inspire generations of viewers. With poetic narration, moving performances, and a message that resonates far beyond the confines of prison bars, The Shawshank Redemption is a film about the resilience of the human spirit and the idea that hope is the one thing no prison can hold.",
    mini_description: "Fear can hold you prisoner. Hope can set you free.",
    poster_url: "movies/the_shawshank_redemption.jpg",
    tmdb_id: 278
  },
  {
    name: "The Dark Knight",
    description: "Christopher Nolan’s The Dark Knight isn't just a superhero movie — it's a gripping psychological thriller that deconstructs the very idea of heroism. As Gotham City tries to recover from crime, a new villain emerges: the Joker, a nihilistic anarchist whose chaos threatens to unravel everything. Bruce Wayne, donning the cape and cowl of Batman, must confront not just the Joker, but the implications of his own vigilantism. The line between right and wrong, law and justice, begins to blur as the stakes rise and lives are lost. Featuring a chilling performance by Heath Ledger and masterful direction, the film redefines the genre with moral complexity, emotional weight, and explosive action. It's a haunting reflection of modern-day fear and the price of standing against it.",
    mini_description: "The night is darkest just before the dawn.",
    poster_url: "movies/the_dark_knight.jpg",
    tmdb_id: 155
  },
  {
    name: "Star Wars: A New Hope",
    description: "In a galaxy plagued by tyranny and war, a humble farm boy named Luke Skywalker stumbles into a destiny that will change the universe. With the guidance of wise Jedi Master Obi-Wan Kenobi, and alongside daring rebels like Princess Leia and smuggler Han Solo, Luke joins the fight against the oppressive Galactic Empire. Facing off against the dark forces of Darth Vader, the young Skywalker learns the ways of the Force and begins his transformation into a hero. Combining space opera spectacle with timeless mythological storytelling, Star Wars: A New Hope captured imaginations across generations. It’s not just a film—it’s the beginning of one of the most iconic sagas ever told.",
    mini_description: "Every saga has a beginning.",
    poster_url: "movies/star_wars_a_new_hope.jpg",
    tmdb_id: 11
  },
  {
    name: "Titanic",
    description: "Titanic is an epic romance set against one of the greatest maritime tragedies in history. On board the ill-fated RMS Titanic, Rose, a young aristocratic woman suffocated by societal expectations, meets Jack, a free-spirited artist living by his own rules. Their passionate love blossoms as the ship makes its maiden voyage—only to be torn apart when the Titanic strikes an iceberg and begins to sink. James Cameron’s sweeping direction, paired with haunting visuals and emotional performances, crafts an unforgettable tale of love, loss, and survival. It's a story that dives deep into class struggle, personal freedom, and the enduring power of memory.",
    mini_description: "Her heart will go on.",
    poster_url: "movies/titanic.jpg",
    tmdb_id: 597
  },
  {
    name: "The Lord of the Rings: The Return of the King",
    description: "The final chapter of the epic trilogy brings the journey of Frodo, Sam, Aragorn, and the fellowship to a thunderous and emotional climax. As the dark lord Sauron prepares his ultimate assault, the forces of Middle-earth unite for one last stand. Frodo and Sam, burdened by the corrupting influence of the One Ring, inch their way to Mount Doom with the help—and hindrance—of the twisted Gollum. Meanwhile, Aragorn must rise to his destiny as the true king of Gondor. With massive battles, heart-wrenching goodbyes, and moments of transcendent hope, The Return of the King is a triumph of fantasy cinema, wrapping up one of the most ambitious adaptations in film history.",
    mini_description: "There can be no triumph without loss.",
    poster_url: "movies/lotr_return_of_the_king.jpg",
    tmdb_id: 122
  }
]

movies.each do |movie|
  Movie.create!(
    name: movie[:name],
    description: movie[:description],
    mini_description: movie[:mini_description],
    poster_url: ActionController::Base.helpers.asset_path(movie[:poster_url]),
    tmdb_id: movie[:tmdb_id]
  )
end

puts "✅ Seed user créé avec succès !"
