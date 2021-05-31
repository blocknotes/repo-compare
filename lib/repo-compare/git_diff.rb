# frozen_string_literal: true

module RepoCompare
  # Compare 2 repos
  class GitDiff
    def initialize(config, result)
      @config = config
      @result = result
    end

    def call
      @result[:results].map do |paths, _hash|
        diff(paths)
      end.join("\n")
    end

    private

    def diff(paths)
      src, dst = paths.split("\t")
      dst ||= src
      `git diff 'remotes/#{@config['source_name']}/#{@config['source_branch']}' -- '#{src}' '#{dst}'`
    end
  end
end
