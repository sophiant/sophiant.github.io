---
title: No input file specified.
date: '2009-10-26'
tags: tech
---

Running nginx and trying to proxy php requests to a fastcgi backend? Testing dummy php page requests and expecting the "standard" nginx 404 page? Getting a cryptic PHP message instead?

This may help. NOTE: the try_files is the key! (only available as of nginx 0.7.27, I believe)
<!--more-->
<pre lang="bash"># pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
#
location ~ .*.php$ {
    try_files  $uri  /404.html;
    fastcgi_pass   127.0.0.1:9000;
    fastcgi_index  index.php;
    fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    include        fastcgi_params;
}</pre>
