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
