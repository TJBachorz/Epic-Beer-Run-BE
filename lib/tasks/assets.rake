# API-only app has no asset pipeline — stub these tasks so Render's buildpack doesn't fail
namespace :assets do
  task :precompile do; end
  task :clean do; end
end
