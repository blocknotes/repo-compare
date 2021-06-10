# frozen_string_literal: true

require 'date'

module RepoCompare
  # Create a diff summary
  class Summary
    def initialize(config, results)
      @config = config
      @count = 0
      @results = results || []
      @name = @config['source_name'] || 'repo-compare'
    end

    def to_xml
      testsuite = testcases
      <<~SUMMARY
<?xml version="1.0" encoding="UTF-8"?>
<testsuite name="#{@name}" tests="#{@count}" skipped="0" failures="#{@count}" errors="#{@count}" time="1" timestamp="#{DateTime.now.iso8601}">
#{testsuite}</testsuite>
      SUMMARY
    end

    private

    def testcase(paths, hash)
      {
        name: paths.gsub(/\t/, ' - '),
        file: paths.split("\t")[-1],
        details: "hash: #{hash}\nfile: #{paths}"
      }
    end

    def testcases
      @results.map do |result|
        result[:results].map do |paths, hash|
          @count += 1
          t = testcase(paths, hash)
          "<testcase name=\"#{t[:name]}\" file=\"#{t[:file]}\" time=\"0\"><failure>#{t[:details]}</failure></testcase>"
        end.join("\n")
      end.join("\n")
    end
  end
end
