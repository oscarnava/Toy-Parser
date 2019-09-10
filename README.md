# Toy parser
This is a very basic class which function is to parse an **.html.erb** file. Its objective is far from being a replacement for ERB templating system, but as an aid for developers who are currious to know how a templating program works. I'm not saying this is the way ERB works, but if you ever think about creating a template processor for some project, maybe this code can aid you getting there.

The whole parser is contained in a class named **ERBParser** and the demo consists of a main template _**master.html.erb**_, an included template _**template.html.erb**_ and a sub-template _**subtemplate.html.erb**_.

## Basic usage:

```ruby
puts ERBParser.new('master.html.erb') << 'template.html.erb' << 'subtemplate.html.erb'
```

This line will output the contents of '_**master**_', yielding in it the contents of '_**template**_', which in turn yields the contents of '_**subtemplate**_'

### Not supported in this version:
* Multiline statements like

```erb
<% 10.times do %>
   .
   .
   .
<% end %>
```
