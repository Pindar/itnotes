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

  def proofer_options
    {
      disable_external: true, enforce_https: false, ignore_missing_alt: true, allow_missing_href: true,
      ignore_files: [%r{/404\.html\z}], ignore_urls: [%r{\A//platform\.twitter\.com/}]
    }
  end
end
