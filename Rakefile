# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

# No-op stubs so Render's buildpack doesn't fail on this API-only app.
# Defined after load_tasks so they only apply when sprockets hasn't defined them.
namespace :assets do
  task :precompile do; end unless Rake::Task.task_defined?('assets:precompile')
  task :clean do; end unless Rake::Task.task_defined?('assets:clean')
end
