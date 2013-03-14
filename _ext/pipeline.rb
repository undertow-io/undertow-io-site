require 'graphviz'

Awestruct::Extensions::Pipeline.new do
  # extension Awestruct::Extensions::Posts.new( '/news' )
   transformer Graphviz.new
end

