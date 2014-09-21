require 'pry'
require 'csv'
require 'ruby-prof'

RubyProf.start

CSV.open("Ratebeer.csv", "w") do |line|
  line << ["name", "beer_id", "brewer_id", "ABV", "style", "appearance", "aroma", "palate", "taste", "overall", "time", "profile_name", "text"]
end

all_data = [{}]
rate_beer_data_file = 'ratebeer.txt'

f = File.open(rate_beer_data_file)
text_block_count = 0

f.each_line do |line|
  left_side = line.partition(' ').first
  right_side = line.partition(' ').last
  all_data[text_block_count][left_side] = right_side.gsub("\n","")

  if line == "\n"
    array = []
    all_data[text_block_count].delete("\n")

    all_data[text_block_count].each do |key, value|
      array << value
    end

    CSV.open("Ratebeer.csv", "a") do |csv|
      csv << array
    end

    text_block_count += 1
    all_data << {}
  end

  break if text_block_count == 100_000
end

# result = RubyProf.stop
# printer = RubyProf::FlatPrinter.new(result)
# printer.print(STDOUT)
