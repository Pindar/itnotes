# frozen_string_literal: true

require 'date'
require 'yaml'

module Itnotes
  # Validates the front matter of every post in <root>/_posts.
  class PostChecker
    REQUIRED_KEYS = %w[layout title date categories].freeze
    FRONT_MATTER = /\A---\s*\n(.*?\n?)^---\s*$\n?/m
    FILENAME_DATE = /\A(\d{4}-\d{2}-\d{2})-/
    # Migrated WordPress/Tumblr posts may legitimately have empty titles or categories.
    EMPTY_VALUES_ALLOWED_BEFORE = '2020-01-01'

    Problem = Struct.new(:file, :message)

    def initialize(root = '.')
      @root = root
    end

    def posts
      Dir.glob(File.join(@root, '_posts', '*.md'))
    end

    def problems
      posts.flat_map { |file| check(file) }
    end

    private

    def check(file)
      match = File.read(file).match(FRONT_MATTER)
      return [problem(file, "#{file} hat keine gültige Frontmatter.")] unless match

      front_matter = parse(match[1])
      return [problem(file, "#{file}: YAML-Fehler in der Frontmatter.")] unless front_matter.is_a?(Hash)

      key_problems(file, front_matter) + date_problems(file, front_matter)
    end

    def parse(yaml)
      YAML.safe_load(yaml, permitted_classes: [Time, Date])
    rescue Psych::Exception
      nil
    end

    def key_problems(file, front_matter)
      missing = REQUIRED_KEYS - front_matter.keys
      return [problem(file, "Fehlende Schlüssel in #{file}: #{missing.join(', ')}")] if missing.any?

      empty = empty_keys(file, front_matter)
      return [] if empty.empty?

      [problem(file, "Leerer Wert in #{file}: #{empty.join(', ')}")]
    end

    def empty_keys(file, front_matter)
      return [] if File.basename(file)[FILENAME_DATE, 1].to_s < EMPTY_VALUES_ALLOWED_BEFORE

      REQUIRED_KEYS.select { |key| front_matter[key].to_s.strip.empty? }
    end

    def date_problems(file, front_matter)
      filename_date = File.basename(file)[FILENAME_DATE, 1]
      front_date = front_matter['date'].to_s[0, 10]
      return [] if filename_date.nil? || front_date.empty? || within_timezone_shift?(filename_date, front_date)

      [problem(file, "Datum in #{file} weicht ab: Dateiname #{filename_date}, Frontmatter #{front_date}")]
    end

    def within_timezone_shift?(first, second)
      (Date.parse(first) - Date.parse(second)).abs <= 1
    rescue Date::Error
      false
    end

    def problem(file, message)
      Problem.new(file, message)
    end
  end
end
