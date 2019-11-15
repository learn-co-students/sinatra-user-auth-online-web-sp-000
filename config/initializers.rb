# write this code in config/initializers/
# Rails will load this logic before booting up Rails server
unless Rails.env.development?
  Gem.path.each do |path|
    Warning.ignore(//, path)
  end
end
