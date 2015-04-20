---
title: Sinatra, Passenger / Nginx, Wordpress
date: '2009-11-04'
tags: tech
---

This blog uses this technology stack (at the time of this writing). I didn't want the basic content pages to running under Wordpress, for a couple of reasons - predominantly because I wanted to use Sinatra and try my hand at Haml. That and a rack config is pretty tight (my entire application is one app.rb file). I pretty much followed the steps outlined by this article to get the basic set up working: http://railsdog.com/blog/2009/06/using-rack-to-combine-sinatra-and-word-press/. However, the web server passenger was running under was for Apache. I finally got this working with the following nginx config snippet.

<!--more -->

<pre lang="bash">
    location / {
passenger_enabled  on;
    }

    location /blog {
passenger_enabled  off;
index          index.html index.htm index.php;

# custom wordpress rewrite for SEO-friendly URLs
#
if (!-e $request_filename) {
    rewrite ^(.+)$ /blog/index.php?q=$1 last;
    break;
}
    }

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    location ~ .*.php$ {
try_files  $uri  /404.html;
fastcgi_pass   127.0.0.1:9000;
fastcgi_index  index.php;
fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
include        fastcgi_params;
    }
</pre>
