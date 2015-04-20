---
title: Upgrading Rails 1.2.6 -> 2.3.4
date: '2009-11-16'
tags: tech
---

Yes, it's pretty sad that I still have a few sites running on 1.2.6. There's been plenty of good articles out there about the various steps you need to take to upgrade your app. Here's a quick rundown of some of the gotchas I ran into during this most recent upgrade for an old client.
<h4>No More acts_as_list</h4>
This one is easy:

<pre lang="bash">ruby script/plugin install acts_as_list</pre>
<h4>File Column</h4>
Back in the day this plugin was the shiznet. Sure there are lots of newer (and better) implementations (try <a href="http://www.thoughtbot.com/projects/paperclip" target="_blank">Thoughbot's Paperclip</a>). But if you are lazy (like me) the file column plugin still works. However, their code relies on what was just the plain vanilla Inflector module. You have to go in and replace all mentions of Inflector with ActiveSupport::Inflector.
<!--more-->
<h4>Paginate</h4>
Pagination is another dead beast. <a href="http://github.com/mislav/will_paginate" target="_blank">Mislav's will_paginate</a> is the de-facto standard it seems these days. Here's a couple of sample diffs of what I had to do in my admin controller's and views to swap it out.
<h5>Controller:</h5>
<pre lang="bash">-    @project_pages, @projects = paginate :projects, :per_page =&gt; 30, :order =&gt; sort_clause
+    @projects = Project.paginate(:page =&gt; params[:page], :per_page =&gt; 10, :order =&gt; sort_clause)</pre>
<h5>View:</h5>
<pre lang="bash">
-<%= render :partial => 'layouts/paginator', :locals => { :paginator => @project_pages } %>
+<%= will_paginate(@projects) %>
</pre>

Easy-peasy.
<h4>No Scaffold</h4>
This one is a little more of a pain. I didn't want to muck around with writing a bunch of controller actions (like I said, I'm lazy!). So I used to have something like this in my controllers:

<pre lang="ruby">
class Admin::ProjectsController &lt; Admin::BaseController
  scaffold :project
  ...stuff...
end
</pre>

To replace this I looked at a few alternatives. Active_scaffolding was probably the "right" approach, but I came across the plugin scaffolding and it seemed like the closest drop-in replacement.

<pre lang="bash">ruby script/plugin install scaffolding</pre>

Now unfortunately that plugin hasn't been kept up to date with all of the latest Rails releases. In particular the plugin uses a template_exists? method that no longer exists in ActionController::Base anymore:

So if you get something like this

<code>undefined method `template_exists?' for #meh</code>

in your logs just add this method to the plugin. I added mine to the private section of scaffolding.rb just before the def render method

<pre lang="ruby">
def template_exists?(path)
  self.view_paths.find_template(path, response.template.template_format)
rescue ActionView::MissingTemplate
  false
end
</pre>
<h4>Closing Thought</h4>
Of course don't forget to
<pre lang="bash">rake rails:update</pre>
