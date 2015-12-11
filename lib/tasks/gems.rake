require "rubygems/package"
require "progress_bar"

namespace :gems do
  desc "Mirror gems from rubygems.org"
  task :mirror do
    Bundler.with_clean_env do
      Dir.chdir Rails.root.join("public") do
        exec "ruby", "--disable-gems", "-I", Rails.root.join("vendor/gem/lib").to_s, "-r", "gem", "-e", "Gem.mirror"
      end
    end
  end

  desc "Create all indexes for all gems"
  task :index do
    Bundler.with_clean_env do
      Dir.chdir Rails.root.join("public") do
        exec "ruby", "--disable-gems", "-I", Rails.root.join("vendor/gem/lib").to_s, "-r", "gem", "-e", "Gem.index"
      end
    end
  end

  namespace :index do
    desc "Create only quick indexes for all gems"
    task :quick do
      Bundler.with_clean_env do
        Dir.chdir Rails.root.join("public") do
          exec "ruby", "--disable-gems", "-I", Rails.root.join("vendor/gem/lib").to_s, "-r", "gem", "-e", "Gem.index_quick"
        end
      end
    end
  end

  desc "Seed gems into database"
  task seed: :environment do
    progress = nil
    print "Discovering gems...\r"
    Dir[Rails.root.join("public", "gems", "*.gem")].tap do |paths|
      progress = ProgressBar.new "Seeding gems", paths.length
    end.each do |name|
      begin
        path = Rails.root.join("public", "gems", name).to_s
        if spec = Gem::Package.new(path).spec
          project = Project.find_or_create_by!(name: spec.name.to_s)
          version = project.versions.find_or_create_by!(number: spec.version.to_s, platform: spec.platform.to_s) do |version|
            version.summary = spec.summary.try(:force_encoding, "utf-8").try(:strip).presence
            version.description = spec.description.try(:force_encoding, "utf-8").try(:strip).presence
          end
        end
      rescue
        progress.puts "Loading #{name} failed: #{$!.class}: #{$!.message}", *$!.backtrace
      end
      progress.increment
    end
    progress.finish
    puts "#{progress.total} gems seeded"
  end
end
