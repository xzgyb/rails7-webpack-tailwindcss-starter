task tailwindcss_build: :environment do
  system("npx tailwindcss -i app/assets/stylesheets/application.tailwind.css -o app/assets/builds/tailwind.css -m", exception: true)
end

task tailwindcss_clobber: :environment do
  rm_rf Dir["app/assets/builds/[^.]*.css"], verbose: false
end

Rake::Task["assets:precompile"].enhance(["tailwindcss_build"])
if Rake::Task.task_defined?("test:prepare")
  Rake::Task["test:prepare"].enhance(["tailwindcss_build"])
elsif Rake::Task.task_defined?("db:test:prepare")
  Rake::Task["db:test:prepare"].enhance(["tailwindcss_build"])
end

Rake::Task["assets:clobber"].enhance(["tailwindcss_clobber"])
