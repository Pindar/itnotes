# frozen_string_literal: true

require 'fileutils'
require 'open3'
require 'tmpdir'

# Builds the Jekyll site once per test run into a temp dir.
module BuiltSite
  ROOT = File.expand_path('../..', __dir__)

  def self.path
    @path ||= build
  end

  def self.build
    dest = Dir.mktmpdir('itnotes-site')
    _out, err, status = Open3.capture3('bundle', 'exec', 'jekyll', 'build', '--quiet', '-d', dest, chdir: ROOT)
    raise "jekyll build failed:\n#{err}" unless status.success?

    at_exit { FileUtils.remove_entry(dest) }
    dest
  end
end
