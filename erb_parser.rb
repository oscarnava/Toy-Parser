class ERBParser

  attr_accessor :contents

  def initialize(template)
    @contents = if template.end_with? '.html.erb'
      File.read(template).to_s
    else
      template
    end
    @template = template
    @subtemplate = nil
    @cache = nil
  end

  def parse
    context = binding
    @cache = @contents.gsub(/<%([=#])?(.*)%>/) do
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
  end

  def <<(template)
    if @subtemplate
      @subtemplate << template
    else
      @subtemplate = ERBParser.new(template)
    end
    self
  end

  def inspect
    "ERBParser('#{@template}') -> #{@subtemplate.inspect}"
  end

  def to_s
    @cache || parse do
      if @subtemplate
        @subtemplate.to_s
      else
        '<!-- Nothing to yield! -->'
      end
    end
  end

end
