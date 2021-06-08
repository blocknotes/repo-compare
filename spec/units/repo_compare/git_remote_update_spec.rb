# frozen_string_literal: true

RSpec.describe RepoCompare::GitRemoteUpdate do
  describe '#call' do
    subject(:call) { instance.call }

    let(:config) { { 'source_name' => 'some_remote_name', 'source_repo' => 'some_git_uri' } }
    let(:instance) { described_class.new(config) }

    let(:git) { instance_double(Git::Base, add_remote: remote, index: index, remotes: remotes) }
    let(:index) { instance_double(Git::Index, writable?: true) }
    let(:remote) { instance_double(Git::Remote, fetch: true, name: 'some_remote_name') }

    before do
      allow(Git).to receive_messages(open: git)
    end

    context 'when the git remote is already present' do
      let(:remotes) { [remote] }

      it { is_expected.to eq(success?: true) }

      it 'opens the git repository and updates the remote source' do
        call
        expect(Git).to have_received(:open)
        expect(remote).to have_received(:fetch)
      end
    end

    context 'when the git remote is not present' do
      let(:remotes) { [] }

      it { is_expected.to eq(success?: true) }

      it 'opens the git repository, add the remote source and updates it' do
        call
        expect(Git).to have_received(:open)
        expect(git).to have_received(:add_remote)
        expect(remote).to have_received(:fetch)
      end
    end

    context 'when the git remote is not present but the index is not writable' do
      let(:index) { instance_double(Git::Index, writable?: false) }
      let(:remotes) { [] }

      it { is_expected.to match(error: /Git index not writable/) }
    end
  end
end
