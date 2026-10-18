# frozen_string_literal: true

require_relative 'lib/itnotes/image_checker'

checker = Itnotes::ImageChecker.new('.')

checker.external.each { |ref| puts "↗️  Externes Bild (nicht geprüft): #{ref.path} in #{ref.file}" }
missing = checker.missing
(checker.local - missing).each { |ref| puts "✅ Bild gefunden: #{ref.path} in #{ref.file}" }
missing.each { |ref| puts "❌ Bild fehlt: #{ref.path} in #{ref.file}" }

exit(missing.empty? ? 0 : 1)
