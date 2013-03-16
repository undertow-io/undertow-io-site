require 'pp'

class Breadcrumbs
  def execute(site)

    site.pages.each do |page|


      path = page.output_path[1..page.output_path.length].split('/')

      page.breadcrumbs = []
      handle(site.documentation, page.breadcrumbs, path, 0, "/")
      page.currentBreadcrumb = page.breadcrumbs[page.breadcrumbs.length-1]
      if page.breadcrumbs.length == 1
        page.breadcrumbs = []
      else
        page.breadcrumbs = page.breadcrumbs[0..page.breadcrumbs.length-2]
      end
    end
  end


  def handle(data, breadcrumbs, path, position, current)
    if position >= path.length
      return
    end
    data.each do |item|
      case item
        when Array
          handle(item, breadcrumbs, path, position, current)
        when Hash
          url = item['url']
          if url[0..url.length-2] == path[position] or url == path[position]
            newPath = current + url;
            breadcrumbs << {:url => newPath, :label => item['label']}
            handle(item['children'], breadcrumbs, path, position + 1, newPath)
          end
      end
    end
  end


end

