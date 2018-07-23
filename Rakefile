namespace :berks do
  task update: :cleanup do
    sh %( while BERKSHELF_PATH='.' berks update | grep Installing; do sleep 0.1; done )
  end

  task :cleanup do
    sh %( rm -rf cookbooks config.json)
  end
end

namespace :style do
  require 'foodcritic'
  desc 'Run the foodcritic linting'
  FoodCritic::Rake::LintTask.new(:foodcritic) do |task|
    task.options = { exclude: 'test/ cookbooks/' }
  end

  require 'rubocop/rake_task'
  # failing only on severity ERROR and FAIL
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.options = ['--fail-level', 'E']
  end
end

namespace :jenkins do
  desc 'Bump the repository patch version'
  task :bump_patch_version do
    Rake::Task[:test].invoke
    version_curr = `git tag --list '[0-9].[0-9].[0-9]*' | tail -n 1`
    array = version_curr.split(/[\.\-]/)
    array.each_with_index { |e, i| array[i] = Integer(e) if /\A\d+\z/.match(e) }
    version_new = array[0].to_s + '.' + array[1].to_s + '.' + (array[2].to_i + 1).to_s
    print "Tagging this version with new patch version: " + version_new
    `git tag #{version_new}`
    `git push --tags`
  end

  desc 'Bump the repository minor version'
  task :bump_minor_version do
    Rake::Task[:test].invoke
    version_curr = `git tag --list '[0-9].[0-9].[0-9]*' | tail -n 1`
    array = version_curr.split(/[\.\-]/)
    array.each_with_index { |e, i| array[i] = Integer(e) if /\A\d+\z/.match(e) }
    version_new = array[0].to_s + '.' + (array[1].to_i + 1).to_s + '.' + array[2].to_s
    print "Tagging this version with new minor version: " + version_new
    `git tag #{version_new}`
    `git push --tags`
  end

  desc 'Bump the repository major version'
  task :bump_major_version do
    Rake::Task[:test].invoke
    version_curr = `git tag --list '[0-9].[0-9].[0-9]*' | tail -n 1`
    array = version_curr.split(/[\.\-]/)
    array.each_with_index { |e, i| array[i] = Integer(e) if /\A\d+\z/.match(e) }
    version_new = (array[0].to_i + 1).to_s + '.' + array[1].to_s + '.' + array[2].to_s
    print "Tagging this version with new major version: " + version_new
    `git tag #{version_new}`
    `git push --tags`
  end
end

# Alias
task style: ['style:foodcritic', 'style:rubocop']

task unit: :'berks:update' do
  sh %( BERKSHELF_PATH='.' rspec --format documentation )
end

# Integration tests
task integration: :'berks:update' do
  sh %( BERKSHELF_PATH='.' kitchen test --destroy=always )
end

# Aliases
task int: ['integration']

desc 'Run all checks and tests'
task test: %w(style unit int)

task default: 'test'
