# frozen_string_literal: true

RSpec.describe RepoCompare::GitDiffRaw do
  describe '#call' do
    subject(:call) { instance.call }

    let(:instance) { described_class.new(config, path) }
    let(:config) do
      {
        'source_name' => 'some_remote_name',
        'source_branch' => 'master',
        'source_base_path' => 'some_base_path',
        'ignore' => {}
      }
    end
    let(:path) { 'some_path' }

    let(:git) { instance_double(Git::Base, lib: git_lib) }
    let(:git_lib) { instance_double(Git::Lib, command: 'result_line') }

    before do
      allow(Git).to receive_messages(open: git)
    end

    it { is_expected.to eq(output: [], results: {}, success?: true) }
  end
end
