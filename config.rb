###
# Compass
###

# Change Compass configuration
compass_config do |config|
  config.add_import_path "bower_components/foundation/scss"
  config.sass_dir = "stylesheets"
  config.output_style = :compact
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end
page "blog/*", layout: :article

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###
helpers do
  def top_bar_menu_item_to(link, url, opts={})
    anchor_tag = link_to(link, url, opts)
    if (current_resource.url == url_for(url)) ||
      (link == 'Blog' && current_resource.url.include?('/blog'))
        prefix = '<li class="active">'
    else
      prefix = '<li>'
    end
    "#{prefix}#{anchor_tag}</li>"
  end
end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes
activate :blog do |blog|
  blog.calendar_template = 'article_collection.html'
  blog.permalink = '{year}/{month}/{title}.html'
  blog.prefix = 'blog'
  blog.summary_separator = /\<\!--more--\>/
  blog.tag_template = 'article_collection.html'
  blog.taglink = 'category/{tag}.html'
end

activate :deploy do |deploy|
  deploy.method = :git
  deploy.branch = 'master'
end

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

activate :directory_indexes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

after_configuration do
  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]
end
