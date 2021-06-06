# frozen_string_literal: true

require 'yaml'

module RepoCompare
  # Load configuration
  class Config
    CONFIG_PATH = '.repo-compare.yml'

    def initialize
      @config = File.exist?(CONFIG_PATH) ? YAML.load_file(CONFIG_PATH) : {}
      @config['paths'] ||= []
      @config['ignore'] ||= {}
      @config['source_branch'] ||= 'master'
    end

    def to_h
      @config.to_h
    end

    def update(results)
      results.each do |result|
        @config['ignore'][result[:src]] ||= {}
        update_conf_path(@config['ignore'][result[:src]], result[:results])
      end
      File.open(CONFIG_PATH, 'w') { |f| f.puts(@config.to_yaml) }
    end

    private

    def update_conf_path(conf, results)
      results.each do |path, hash|
        conf[path] = hash
      end
    end
  end
end
