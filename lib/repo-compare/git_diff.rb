# frozen_string_literal: true

require 'git'

module RepoCompare
  # Compare 2 repos
  class GitDiff
    def initialize(config, result)
      @config = config
      @result = result
    end

    def call(path: Dir.pwd)
      git = Git.open(path)
      branch = ['remotes', @config['source_name'], @config['source_branch']].join('/')
      @result[:results].map do |paths, _hash|
        diff(git, branch, paths)
      end.join("\n")
    end

    private

    def diff(git, branch, paths)
      src, dst = paths.split("\t")
      dst ||= src
      git.lib.send(:command, 'diff', branch, '--', src, dst)
    end
  end
end
