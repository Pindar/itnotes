# frozen_string_literal: true

require_relative 'lib/itnotes/post_checker'

checker = Itnotes::PostChecker.new('.')
problems = checker.problems

(checker.posts - problems.map(&:file)).each { |file| puts "#{file} hat gültige Frontmatter." }
problems.each { |problem| puts problem.message }

exit(problems.empty? ? 0 : 1)
