# frozen_string_literal: true

require 'itnotes/post_checker'

RSpec.describe Itnotes::PostChecker do
  def messages_for(fixture)
    described_class.new(File.join(FIXTURES, fixture)).problems.map(&:message)
  end

  context 'when every post has complete front matter' do
    it 'reports no problems' do
      expect(messages_for('valid')).to be_empty
    end
  end

  context 'when a post has no front matter' do
    it 'reports it' do
      expect(messages_for('broken')).to include(a_string_matching(/ohne-front-matter.*keine gültige Frontmatter/))
    end
  end

  context 'when required keys are missing' do
    it 'names the missing keys' do
      expect(messages_for('broken')).to include(a_string_matching(/fehlt\.md.*date, categories/))
    end
  end

  context 'when a required value is empty' do
    it 'reports the empty key' do
      expect(messages_for('broken')).to include(a_string_matching(/Leerer Wert.*leer\.md.*title/))
    end
  end

  context 'when the filename date differs from the front matter date' do
    it 'reports the mismatch' do
      expect(messages_for('broken')).to include(a_string_matching(/Datum.*datum\.md/))
    end
  end

  context 'when a legacy post (before 2020) has empty values' do
    it 'accepts them, since migrated Tumblr posts have no title or category' do
      expect(messages_for('broken')).not_to include(a_string_matching(/legacy-leer/))
    end
  end

  context 'when the date differs from the filename only by timezone shift (one day)' do
    it 'accepts it' do
      expect(messages_for('valid')).to be_empty
    end
  end

  context 'when the YAML cannot be parsed' do
    it 'reports a YAML error instead of crashing' do
      expect(messages_for('broken')).to include(a_string_matching(/yaml\.md.*YAML/))
    end
  end
end
