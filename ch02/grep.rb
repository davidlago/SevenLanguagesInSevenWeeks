def grep(filename, text)
  File.open(filename, "r") do |file_handle|
    line_number = 0
    my_regexp = Regexp.new(text)

    file_handle.each_line do |line|
      line_number += 1
      unless my_regexp.match(line).nil?
        puts "#{line_number} => #{line}"
      end
    end
  end
end

grep("test_file.txt", "test")
