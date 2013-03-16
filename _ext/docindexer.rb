require 'pp'

class Docindexer
  def execute(site)
    handle(site, site.documentation, "/")
  end
end

def handle(site, data, path)
  data.each do |item|
    case item
      when Array
        handle(site, item, path)
      when Hash
        if item['children']
          handle(site, item['children'], path + item['url'])

          index = File.join(File.dirname(__FILE__), 'index.html.haml')
          page = site.engine.load_page(index)
          page.output_path = path + item['url'] + 'index.html'
          page.data = item
          site.pages << page
        end
    end
  end
end
