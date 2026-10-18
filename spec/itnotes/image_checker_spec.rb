# frozen_string_literal: true

require 'itnotes/image_checker'

RSpec.describe Itnotes::ImageChecker do
  def checker(fixture)
    described_class.new(File.join(FIXTURES, fixture))
  end

  context 'when all local images exist' do
    it 'reports no missing images' do
      expect(checker('valid').missing).to be_empty
    end

    it 'lists external images separately without checking them' do
      expect(checker('valid').external.map(&:path)).to eq(['https://example.com/x.png'])
    end
  end

  context 'when images are missing' do
    it 'finds markdown images' do
      expect(checker('broken').missing.map(&:path)).to include('/assets/weg.png')
    end

    it 'finds HTML img tags' do
      expect(checker('broken').missing.map(&:path)).to include('/assets/weg2.png')
    end
  end
end
