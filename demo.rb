
require_relative 'erb_parser.rb'

parser = ERBParser.new('master.html.erb', compress: true) << 'template.html.erb' << 'subtemplate.html.erb'

puts "\nParser struct:\n~~~~~~~~~~~~~"
p parser

puts "\nParsed result:\n~~~~~~~~~~~~~"
puts parser
puts "~~~~~~~~~~~~~"

