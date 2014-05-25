# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Happiness::Application.load_tasks

namespace :spec do
  task :clean do
    FileUtils.rm_rf(Dir.glob('spec/vcr/*'))
  end
end
