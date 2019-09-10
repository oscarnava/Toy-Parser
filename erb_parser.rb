class ERBParser

  attr_accessor :contents

  def initialize(template)
    @contents = if template.end_with? '.html.erb'
      File.read(template).to_s
    else
      template
    end
    @subtemplate = nil
  end

  def parse
    context = binding
    @contents.gsub!(/<%([=#])?(.*)%>/) do
      cmd = $2.strip
      case $1
      when '='
        eval(cmd, context)
      when '#'
        ''
      else
        eval(cmd, context)
        ''
      end
    end #.gsub(/>\s+</,'><')
    @contents
  end

  def <<(template)
    if @subtemplate
      @subtemplate << template
    else
      @subtemplate = ERBParser.new(template)
    end
    self
  end

  def to_s
    parse {
      if @subtemplate
        @subtemplate.to_s
      else
        '<!-- Nothing to yield! -->'
      end
    }
  end

end

puts ERBParser.new('master.html.erb') << 'template.html.erb' << 'subtemplate.html.erb'
