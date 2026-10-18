# frozen_string_literal: true

module Itnotes
  # Finds images referenced by posts (Markdown and HTML) and checks that local ones exist.
  class ImageChecker
    MARKDOWN_IMAGE = /!\[[^\]]*\]\(\s*([^)\s]+)[^)]*\)/
    HTML_IMAGE = /<img\b[^>]*?\bsrc=["']([^"']+)["']/i
    EXTERNAL = %r{\A(?:https?:)?//}

    Reference = Struct.new(:path, :file)

    def initialize(root = '.')
      @root = root
    end

    def references
      Dir.glob(File.join(@root, '_posts', '*.md')).flat_map do |file|
        content = File.read(file)
        paths = content.scan(MARKDOWN_IMAGE) + content.scan(HTML_IMAGE)
        paths.flatten.map { |path| Reference.new(path, file) }
      end
    end

    def external
      references.grep(->(ref) { ref.path.match?(EXTERNAL) })
    end

    def local
      references - external
    end

    def missing
      local.reject { |ref| File.exist?(File.join(@root, ref.path.delete_prefix('/'))) }
    end
  end
end
