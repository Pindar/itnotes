require 'yaml'

# Pfade definieren
posts_dir = './_posts'
assets_dir = './assets'

# Alle Markdown-Dateien im _posts-Ordner durchsuchen
Dir.glob("#{posts_dir}/*.md").each do |file|
  content = File.read(file)

  # Bildreferenzen im Markdown finden (z. B. ![Alt-Text](Pfad/zum/Bild.jpg))
  image_references = content.scan(/!\[.*?\]\((.*?)\)/).flatten

  # Überprüfen, ob die Bilder im assets-Ordner existieren
  image_references.each do |image_path|
    # Entferne führende "/" für relative Pfade
    relative_path = image_path.sub(/^\//, '')

    # Vollständigen Pfad zum Bild erstellen
    full_path = File.join(assets_dir, relative_path)

    # Überprüfung
    if File.exist?(full_path)
      puts "✅ Bild gefunden: #{image_path} in #{file}"
    else
      puts "❌ Bild fehlt: #{image_path} in #{file}"
    end
  end
end