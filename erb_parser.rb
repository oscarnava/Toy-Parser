class ERBParser

  attr_reader :contents

  def initialize(template, compress: false)
    @contents = if template.end_with? '.html.erb'
      File.read(template).to_s
    else
      template
    end
    @template = template
    @compress = compress
    @subtemplate = nil
    @cache = nil
  end

  def parse(compress)
    context = binding
    @cache = @contents.gsub(/<%(#\S*|=|)\s*(.+)\s*%>/) do
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
    end

    @cache.tap do |s|
      s.gsub!(/>(?:\s|\t|\n|\r)+</,'><').gsub!(/(?:\t|\n\s*|\r\s*)+/,'') if compress
    end
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
    @cache || parse(@compress) do
      if @subtemplate
        @subtemplate.to_s
      else
        '<!-- Nothing to yield! -->'
      end
    end
  end

end
