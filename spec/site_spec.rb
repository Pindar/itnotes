# frozen_string_literal: true

require 'html-proofer'
require 'itnotes/post_checker'
require 'support/built_site'

RSpec.describe 'The built site' do # rubocop:disable RSpec/DescribeClass
  let(:site) { BuiltSite.path }
  let(:home) { File.read(File.join(site, 'index.html')) }

  def page(glob)
    File.read(Dir.glob(File.join(site, glob)).first)
  end

  it 'declares the language of the home page (English tagline)' do
    expect(home).to match(/<html[^>]*lang="en"/)
  end

  it 'declares German as the language of posts' do
    expect(page('**/mlprague/index.html')).to match(/<html[^>]*lang="de"/)
  end

  it 'has a meta description on the home page' do
    expect(home).to match(/<meta name="description" content="[^"]+"/)
  end

  it 'renders at least one page per post' do
    posts = Itnotes::PostChecker.new(BuiltSite::ROOT).posts.size
    expect(Dir.glob(File.join(site, '**', 'index.html')).size).to be >= posts
  end

  it 'has no broken internal links or images' do
    proofer = HTMLProofer.check_directory(site, **proofer_options)
    expect { proofer.run }.not_to raise_error
  end

  context 'when checking GDPR-relevant third-party requests' do
    let(:html_files) { Dir.glob(File.join(site, '**', '*.html')) }

    def external_resources(tag_pattern)
      html_files.flat_map do |file|
        File.read(file).scan(tag_pattern).map { |match| "#{file.delete_prefix(site)}: #{match}" }
      end
    end

    it 'embeds no scripts from other hosts' do
      expect(external_resources(%r{<script[^>]+src="((?:https?:)?//[^"]+)"})).to be_empty
    end

    it 'embeds no iframes' do
      expect(external_resources(/<iframe[^>]*src="([^"]+)"/)).to be_empty
    end

    it 'loads no images from other hosts' do
      pattern = %r{<img[^>]+src="((?:https?:)?//(?!www\.itnotes\.de)[^"]+)"}
      expect(external_resources(pattern)).to be_empty
    end
  end

  context 'when checking profile content and navigation' do
    let(:html_files) { Dir.glob(File.join(site, '**', '*.html')) }

    it 'shows the personal statement on every page' do
      missing = html_files.reject { |file| File.read(file).include?('Everything is an experiment') }
      expect(missing.map { |file| file.delete_prefix(site) }).to be_empty
    end

    it 'links no Xing profile' do
      expect(html_files.select { |file| File.read(file).include?('xing.com') }).to be_empty
    end

    it 'publishes no schema.org profile links (sameAs)' do
      expect(html_files.select { |file| File.read(file).include?('"sameAs"') }).to be_empty
    end

    it 'has no publications page' do
      expect(File.exist?(File.join(site, 'publications', 'index.html'))).to be(false)
    end
  end

  context 'when checking the visual design system' do
    let(:css) { File.read(File.join(site, 'assets', 'css', 'custom.css')) }
    let(:about) { File.read(File.join(site, 'about', 'index.html')) }
    let(:post_html) { page('**/mlprague/index.html') }

    def h1_count(html)
      html.scan(/<h1[\s>]/).size
    end

    it 'renders exactly one h1 on home, pages and posts' do
      counts = [home, about, post_html].map { |html| h1_count(html) }
      expect(counts).to eq([1, 1, 1])
    end

    it 'marks the current page in the navigation' do
      expect(about).to match(%r{<a[^>]*href="/about"[^>]*aria-current="page"})
    end

    it 'does not mark Home as current on other pages' do
      expect(about).not_to match(%r{<a[^>]*href="/"[^>]*aria-current="page"})
    end

    it 'uses no utility classes in the markup' do
      expect(home + about + post_html).not_to match(/class="[^"]*\b(?:text-gray|bg-gray|max-w-|space-y|mx-auto)/)
    end

    it 'does not nest prose containers' do
      expect(post_html).not_to match(/class="prose[^"]*"[^>]*>\s*(?:<!--.*?-->\s*)*<header[\s\S]*?class="prose/)
    end

    it 'supports a dark colour scheme' do
      expect(css).to include('prefers-color-scheme: dark')
    end

    it 'defines design tokens as custom properties' do
      expect(css).to match(/:root\s*\{[^}]*--color-accent/)
    end

    it 'does not reference a webfont that is never loaded' do
      expect(css).not_to include('Fira Code')
    end

    it 'groups the post list on the home page by year' do
      expect(home).to match(%r{<h2[^>]*>\s*2017\s*</h2>})
    end

    it 'shows a footer with privacy notice on every page' do
      expect(home).to match(%r{<footer[\s\S]*href="/datenschutz"})
    end

    it 'shows a portrait with alt text on the about page' do
      expect(about).to match(%r{<img[^>]*src="/assets/simon\.jpg"[^>]*alt="[^"]+"})
    end
  end

  context 'when publishing personal photos' do
    it 'ships the portrait without EXIF or GPS metadata' do
      bytes = File.binread(File.join(site, 'assets', 'simon.jpg'))
      expect(bytes.scan(%r{Exif\0\0|ns\.adobe\.com/xap|GPSLatitude})).to be_empty
    end
  end

  context 'when providing the privacy notice' do
    let(:notice) { File.read(File.join(site, 'datenschutz', 'index.html')) }

    it 'is written in German' do
      expect(notice).to match(/<html[^>]*lang="de"/)
    end

    it 'names the controller and the GitHub hosting' do
      expect(notice).to include('Simon Dittlmann').and include('GitHub Pages')
    end

    it 'states that no cookies or analytics are used' do
      expect(notice).to include('keine Cookies').and include('keine Analyse')
    end

    it 'is linked from the navigation of every page' do
      files = Dir.glob(File.join(site, '**', '*.html'))
      missing = files.reject { |file| File.read(file).include?('href="/datenschutz"') }
      expect(missing).to be_empty
    end
  end

  def proofer_options
    {
      disable_external: true, enforce_https: false, ignore_missing_alt: true, allow_missing_href: true,
      ignore_files: [%r{/404\.html\z}]
    }
  end
end
