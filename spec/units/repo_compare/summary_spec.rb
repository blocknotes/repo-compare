# frozen_string_literal: true

require 'ox'

RSpec.describe RepoCompare::Summary do
  describe '#to_xml' do
    subject(:to_xml) { described_class.new(config, results).to_xml }

    let(:config) { {} }
    let(:results) { nil }

    it 'generates an XML summary with a testsuite array' do
      required_keys = %i[errors name skipped tests timestamp]

      xml = Ox.load(to_xml, mode: :hash)
      expect(xml).to match(testsuite: match_array(hash_including(*required_keys)))
    end
  end
end
