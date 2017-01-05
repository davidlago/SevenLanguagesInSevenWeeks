module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  class CsvRow
    attr_accessor :headers, :contents

    def initialize(headers:, contents:)
      @headers = headers
      @contents = contents
    end

    def method_missing header
      index = headers.index(header.to_s)
      throw "Method #{header} is not implemented!" if index.nil?
      contents[index]
    end
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end
    end

    def each
      csv_contents.each do |row|
        yield CsvRow.new(headers: headers, contents: row)
      end
    end

    attr_accessor :headers, :csv_contents

    def initialize
      read
    end
  end
end

class RubyCsv  # no inheritance! You can mix it in
  include ActsAsCsv
  acts_as_csv
end

csv = RubyCsv.new
csv.each {|row| puts row.one}   # "lions"
csv.each {|row| puts row.two}   # "tigers"
csv.each {|row| puts row.three} # Exception thrown!
