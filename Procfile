web: bundle exec rails server -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -t 25 -c 5 -q default -q mailers -q urgent,2
