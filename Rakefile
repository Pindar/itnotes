# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:rubocop)

desc 'Validate post front matter'
task :posts do
  ruby 'check_posts.rb'
end

desc 'Validate image references'
task :images do
  ruby 'check_images.rb'
end

desc 'Run Node-based linters (markdown, css, js, html, yaml)'
task :lint do
  sh 'npm run --silent lint:md && npm run --silent lint:css && npm run --silent lint:js ' \
     '&& npm run --silent lint:html && npm run --silent lint:yaml'
end

desc 'Activate repo git hooks (gitleaks pre-commit)'
task :setup do
  sh 'git config core.hooksPath .githooks'
end

desc 'Run all checks'
task check: %i[rubocop spec posts images lint]

task default: :check
