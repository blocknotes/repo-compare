# frozen_string_literal: true

RSpec.describe RepoCompare::Config do
  describe 'initialize' do
    subject(:config_instance) { described_class.new }

    context 'without a config file' do
      before do
        allow(File).to receive(:exist?).and_return(false)
        allow(YAML).to receive(:load_file).and_return({})
        config_instance
      end

      it 'loads the option from file' do
        expect(YAML).not_to have_received(:load_file)
      end
    end

    context 'with a config file' do
      before do
        allow(File).to receive(:exist?).and_return(true)
        allow(YAML).to receive(:load_file).and_return({})
        config_instance
      end

      it 'loads the option from file' do
        expect(YAML).to have_received(:load_file)
      end
    end
  end

  describe '#to_h' do
    subject(:to_h) { described_class.new.to_h }

    it 'returns the initial config' do
      expected_config = { 'ignore' => {}, 'paths' => ['./'], 'source_branch' => 'master' }

      expect(to_h).to eq expected_config
    end
  end

  describe '#update' do
    subject(:update) { described_class.new.update(results) }

    let(:results) { {} }

    before do
      allow(File).to receive(:open)
      update
    end

    it 'updates the config file' do
      expect(File).to have_received(:open).with(described_class::CONFIG_PATH, 'w')
    end
  end
end
