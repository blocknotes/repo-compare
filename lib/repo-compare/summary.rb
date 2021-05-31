# frozen_string_literal: true

require 'date'

module RepoCompare
  # Create a diff summary
  class Summary
    def initialize(results)
      @count = 0
      @results = results || []
    end

    def to_xml
      <<~SUMMARY
<?xml version="1.0" encoding="UTF-8"?>
<testsuite name="solidus_compare" tests="#{@count}" skipped="0" failures="#{@count}" errors="#{@count}" time="1" timestamp="#{DateTime.now.iso8601}">
#{testcases}</testsuite>
      SUMMARY
    end

    private

    def testcases
      @results.map do |result|
        result[:results].map do |paths, hash|
          @count += 1
          # result[:src]
          name = paths.gsub(/\t/, ' - ')
          file = paths.split("\t")[-1]
          "<testcase name=\"#{name}\" file=\"#{file}\" time=\"0\"><failure>hash: #{hash}\nfile: #{paths}</failure></testcase>"
        end.join("\n")
      end.join("\n")
    end
  end
end
