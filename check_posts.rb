require 'yaml'

posts_dir = './_posts'

Dir.glob("#{posts_dir}/*.md").each do |file|
  content = File.read(file)
  if content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
    frontmatter = YAML.safe_load($1, permitted_classes: [Time, Date])
    required_keys = %w[layout title date categories]

    missing_keys = required_keys - frontmatter.keys
    if missing_keys.any?
      puts "Fehlende Schlüssel in #{file}: #{missing_keys.join(', ')}"
    else
      puts "#{file} hat gültige Frontmatter."
    end
  else
    puts "#{file} hat keine gültige Frontmatter."
  end
end