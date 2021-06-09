# frozen_string_literal: true

require 'git'

module RepoCompare
  # Compare 2 repos
  class GitDiffRaw
    DIFF_OPTIONS = '--cc --raw'
    EXP = /:\w+ \w+ (?<src>\w+) (?<dst>\w+) (?<status>\w+)\t(?<path>.+)/.freeze

    def initialize(config, path)
      @config = config
      @context = { output: [] }
      @path = path
    end

    def call(path: Dir.pwd)
      git = Git.open(path)
      compare_repos(git)
      filter_changes
      extract_results
      @context[:success?] = true
      @context
    end

    private

    def compare_repos(git)
      branch = ['remotes', @config['source_name'], @config['source_branch']].join('/')
      src_path = "#{@config['source_base_path']}/#{@path}"
      output = git.lib.send(:command, 'diff', '--cc', '--raw', branch, '--', src_path, @path)
      @context[:output] = output.scan(EXP)
      @context
    end

    def extract_results
      @context[:output].sort_by! { |item| item[3] }
      @context[:results] = {}
      @context[:output].each_with_object(@context[:results]) do |item, ret|
        ret[item[3]] = item[0]
      end
      @context
    end

    def filter_changes
      ignore = @config['ignore'][@path] || []
      @context[:output].reject! { |line| line[0] == line[1] || ignore_changes?(ignore, line) }
      @context
    end

    def ignore_changes?(ignore, line)
      path = line[3]
      ignore[path] == '-' || ignore[path] == line[0]
    end
  end
end
