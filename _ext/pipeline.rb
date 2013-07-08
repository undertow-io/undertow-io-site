require 'wget_wrapper'
require 'js_minifier'
require 'css_minifier'
require 'html_minifier'
require 'file_merger'
require 'less_config'
require 'graphviz'
require 'docindexer'
require 'breadcrumbs'
require 'bootstrap-sass'

Awestruct::Extensions::Pipeline.new do
  extension Docindexer.new
  transformer Graphviz.new
  extension Breadcrumbs.new
	helper Awestruct::Extensions::Partial
	extension Awestruct::Extensions::WgetWrapper.new
	transformer Awestruct::Extensions::JsMinifier.new
	transformer Awestruct::Extensions::CssMinifier.new
	transformer Awestruct::Extensions::HtmlMinifier.new
	extension Awestruct::Extensions::FileMerger.new
  extension Awestruct::Extensions::LessConfig.new
end

