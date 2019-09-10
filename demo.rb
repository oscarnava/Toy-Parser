
require_relative 'erb_parser.rb'

parser = ERBParser.new('master.html.erb') << 'template.html.erb' << 'subtemplate.html.erb'
p parser
puts parser

