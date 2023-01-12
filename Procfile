web: RUBYOPT='--enable-yjit' bundle exec rails server -p $PORT
release: bundle exec rails db:migrate
worker: RUBYOPT='--enable-yjit' bundle exec sidekiq
