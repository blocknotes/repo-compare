# frozen_string_literal: true

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

    def call
      compare_repos
      filter_changes
      extract_results
      @context[:success?] = true
    end

    private

    def compare_repos
      cmd =  "git diff #{DIFF_OPTIONS} 'remotes/#{@config['source_name']}/#{@config['source_branch']}' -- "
      cmd += "'#{@config['source_base_path']}/#{@path}' '#{@path}'"
      @context[:output] = `#{cmd}`.scan(EXP)
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
