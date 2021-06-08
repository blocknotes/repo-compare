# frozen_string_literal: true

require 'git'

module RepoCompare
  # Update the remote source
  class GitRemoteUpdate
    def initialize(config)
      @config = config || {}
      @error = nil
    end

    # Update the git remote source, if it is not presente it will be added
    #
    # - path: path of the local git repository (default: current working directory)
    #
    # Returns an hash with `success?` true when there are no errors.
    # Otherwise returns an hash with `error`.
    def call(path: Dir.pwd)
      git = git_open(path)
      return @error unless git

      remote = git.remotes.find { |r| r.name == @config['source_name'] }
      remote ||= git_remote_add(git)
      return @error unless remote

      return @error unless git_remote_update(remote)

      { success?: true }
    end

    private

    def fail(error = nil)
      @error = { error: error }
      nil
    end

    def git_open(path)
      Git.open(path)
    rescue ArgumentError => e
      fail("git_open - #{e.inspect}")
    end

    def git_remote_add(git)
      return fail('git_remote_add - Git index not writable') unless git.index.writable?

      git.add_remote(@config['source_name'], @config['source_repo'])
    rescue Git::GitExecuteError => e
      fail("git_remote_add - #{e.inspect}")
    end

    def git_remote_update(remote)
      remote.fetch
      true
    rescue Git::GitExecuteError => e
      fail("git_remote_update - #{e.inspect}")
    end
  end
end
