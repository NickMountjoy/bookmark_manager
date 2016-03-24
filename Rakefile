require 'data_mapper'
require 'dm-postgres-adapter'
require './app/app.rb'

namespace :db do
  desc "non desturctive upgrade"
  task :upgrade do
    DataMapper.auto_upgrade!
    puts "Auto-upgrade complete (with no data loss)"
  end

  desc "destructive upgrade"
  task :migrate do
    DataMapper.auto_migrate!
    puts "Auto-migrate compelte (data was lost)"
  end
end
