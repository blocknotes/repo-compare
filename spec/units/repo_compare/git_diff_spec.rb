# frozen_string_literal: true

RSpec.describe RepoCompare::GitDiff do
  describe '#call' do
    subject(:call) { instance.call }

    let(:config) { { 'source_name' => 'some_remote_name', 'source_branch' => 'master' } }
    let(:instance) { described_class.new(config, { results: diff }) }
    let(:diff) do
      {
        "some_new_file" => "0000000000",
        "some_old_file" => "e9d5a4e7a3",
        "some_file_1\tsome_file_2" => "8487ed154a",
        "some_file_3\tsome_file_4" => "af47daffbd"
      }
    end

    let(:git) { instance_double(Git::Base, lib: git_lib) }
    let(:git_lib) { instance_double(Git::Lib, command: 'result_line') }

    before do
      allow(Git).to receive_messages(open: git)
    end

    it { is_expected.to be_a String }

    it 'calls a git diff for each line' do
      expect(call.split('result_line').count).to eq 4
    end
  end
end
