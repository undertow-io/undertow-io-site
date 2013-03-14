class Graphviz
  def transform(site, page, input)
    ext = File.extname(page.output_path)[1..-1].to_sym
    case ext
      when :dot
        system("dot -Tpng ." + page.url + " >"  + site.output_dir + page.output_path[0..(page.output_path.length-5)] + ".png")
    end
    return input
  end
end
