require 'graphviz'
require 'docindexer'

Awestruct::Extensions::Pipeline.new do
  # extension Awestruct::Extensions::Posts.new( '/news' )
  extension Docindexer.new
  transformer Graphviz.new
end

