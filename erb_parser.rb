def parse(template)
  context = binding
  input = File.read(template)
  html = input.to_s
  html.gsub(/<%([=#])?(.*)%>/) do
    case $1
    when '='
      eval($2, context)
    when '#'
      ''
    else
      eval($2, context)
      ''
    end
  end #.gsub(/>\s+</,'><')
end

puts parse('master.html.erb') { parse('home.html.erb') }
