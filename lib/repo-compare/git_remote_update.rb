# frozen_string_literal: true

module RepoCompare
  # Update the remote source
  class GitRemoteUpdate
    def initialize(config)
      @config = config
    end

    def call
      if `git remote`.split("\n").none? @config['source_name']
        `git remote add -f #{@config['source_name']} #{@config['source_repo']}`
        puts('error with git remote add') & exit if $?.exitstatus != 0
      end

      `git remote update > /dev/null 2>&1`
      puts('error with git remote update') & exit if $?.exitstatus != 0
    end
  end
end
