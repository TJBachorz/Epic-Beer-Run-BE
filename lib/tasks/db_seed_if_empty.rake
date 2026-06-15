namespace :db do
  task seed_if_empty: :environment do
    if Brewery.count.zero?
      puts "No brewery data found, seeding..."
      Rake::Task['db:seed'].invoke
      puts "Seeding complete."
    else
      puts "Brewery data already present (#{Brewery.count} records), skipping seed."
    end
  end
end
