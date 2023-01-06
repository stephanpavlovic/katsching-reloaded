require 'colorize'

namespace :dev do
  DUMP_FILE_PATH = Rails.root.join('tmp', 'production.dump')

  desc 'Checks if heroku & postgres tooling is available and setup'
  task :pre_checks do
    puts 'Check requirements'.yellow
    # Check if heroku cli is installed
    Bundler.with_clean_env do
      sh 'which heroku &> /dev/null', verbose: false do |ok, res|
        if !ok
          puts 'You need to install the heroku cli:'.red
          puts '  https://devcenter.heroku.com/articles/heroku-cli'
          exit(-1)
        end
      end
    end

    # Check if pg_restore is available
    sh 'which pg_restore &> /dev/null', verbose: false do |ok, res|
      if !ok
        puts 'Command `pg_restore` not found.'.red
        puts 'You need to install postgres cli utilities.'
        exit(-1)
      end
    end

    # Check if user has access to railslove on heroku
    Bundler.with_clean_env do
      sh 'heroku apps --team=railslove &> /dev/null', verbose: false do |ok, res|
        if !ok
          puts 'Your heroku-cli account is not connected to team railslove.'.red
          puts 'Use an account which has access to team railslove.'
          puts '  https://github.com/heroku/heroku-accounts'
          exit(-1)
        end
      end
    end

    puts 'Everything is okay!'.green
    puts ''
  end

  desc 'Fetch production database dump from heroku'
  task fetch_db_dump: :environment do
    puts "Fetching dump from heroku ..."
    Bundler.with_clean_env { sh "heroku pg:backups:download --app=katsching2 --output=#{DUMP_FILE_PATH}" }
    puts "done.".green
  end

  desc "Import dump stored in #{DUMP_FILE_PATH}"
  task :import_db_dump do
    config = ActiveRecord::Base.connection_db_config.configuration_hash#.slice(:host, :port, :username, :database)

    cmd = "pg_restore --verbose --clean --no-owner --no-acl -n public --dbname #{config[:database]}"
    cmd += " --host #{config[:host]}" if config[:host]
    cmd += " --port #{config[:port]}" if config[:port]
    cmd += " --username #{config[:username]}" if config[:username]
    cmd += " #{DUMP_FILE_PATH}"

    sh cmd

    puts "done.".green
  end

  desc "Fetch and import production data"
  task :prime do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:schema:load"].invoke
    Rake::Task["dev:fetch_db_dump"].invoke
    Rake::Task["dev:import_db_dump"].invoke
    Rake::Task["db:migrate"].invoke
    puts "done.".green
  end

  task :fetch_db_dump => :pre_checks
  task :import_db_dump => :pre_checks
  task :prime => :pre_checks
end
