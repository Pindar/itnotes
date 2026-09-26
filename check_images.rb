require 'yaml'

# Pfade definieren
posts_dir = './_posts'
site_root = '.'

# Alle Markdown-Dateien im _posts-Ordner durchsuchen
Dir.glob("#{posts_dir}/*.md").each do |file|
  content = File.read(file)

  # Bildreferenzen im Markdown finden (z. B. ![Alt-Text](Pfad/zum/Bild.jpg))
  image_references = content.scan(/!\[.*?\]\((.*?)\)/).flatten

  # Überprüfen, ob die Bilder existieren
  image_references.each do |image_path|
    # Externe URLs können nicht lokal geprüft werden
    if image_path =~ %r{^https?://}
      puts "↗️  Externes Bild (nicht geprüft): #{image_path} in #{file}"
      next
    end

    # Bildpfade sind bereits site-root-relativ (z. B. /assets/foo.png)
    relative_path = image_path.sub(/^\//, '')
    full_path = File.join(site_root, relative_path)

    if File.exist?(full_path)
      puts "✅ Bild gefunden: #{image_path} in #{file}"
    else
      puts "❌ Bild fehlt: #{image_path} in #{file}"
    end
  end
end