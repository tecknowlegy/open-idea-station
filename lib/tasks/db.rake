unless Rails.env.production?
  require "faker"

  # lib/tasks/db.rake
  namespace :db do
    desc "Drop, create, migrate then seed the development database"
    task reseed: ["db:drop", "db:create", "db:migrate", "db:seed"] do
      puts "Reseeding completed."
    end

    desc "Fill database with sample data"
    task seed: :environment do
      Faker::Config.locale = :en
      20.times do
        # create user
        user = User.create!(
          username: Faker::Name.unique.first_name,
          email: Faker::Internet.unique.email,
          password: "123456"
        )

        # create idea
        user.ideas.create!(
          name: Faker::Name.unique.name,
          description: Faker::Lorem.sentence,
          url: Faker::Internet.url,
          is_archived: false,
          published_at: Faker::Date.between(2.days.ago, Date.today)
        )
      end
    end
  end
else
  namespace :db do
    desc "Perform operations based on db existence"
    task check_database: :environment do
      database_existence_handler
    end

    desc "Fill database with sample data"
    task seed: :environment do
    end

    desc "Update database with slug_name"
    task update_slug: :environment do
      Idea.all.map(&:save)
    end
  end
end

def database_existence_handler
  ActiveRecord::Base.connection
rescue ActiveRecord::NoDatabaseError
  task reseed: ["db:create", "db:migrate", "db:seed"] do
    puts "Reseeding completed."
  end
else
  task migrate: ["db:migrate", "db:update_slug"] do
    puts "Migration completed."
  end
end


