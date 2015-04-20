---
title: Custom Subversion Build on Mac OS X
date: '2010-01-14'
tags: tech
---

A few weeks back I found myself having to build subversion from scratch on Mac OS X. I think the version that comes shipped on the mac is a few revs back and if I recall we were having trouble with unfuddle, and their recommendation at the time (though they subsequently fixed the issue) was to upgrade your subversion client to the latest version. As of this writing that was v1.6.6

There was a serious "gotcha" that I ran across when trying to build the subversion libraries (I was getting an obscure "symbol not found: _ne_set_connect_timeout" error), and it had to do with the LDFLAGS environment variable that the auto-generated Makefile created. Here are my notes on what I had to do in order to get this working. Note: this assumes that you have all of the Mac Developer tools already installed. There are lots of posts on the interwebs on how to do that.
<!--more-->
First, you need to download and build from source the latest neon package - which is Subversion's HTTP Library. This is a pretty standard install (I typically do all of these as root):

<pre lang="bash">
wget http://www.webdav.org/neon/neon-0.29.0.tar.gz
tar xzf neon-0.29.0.tar.gz
cd neon-0.29.0
./configure --with-ssl
make
make install
</pre>

Note in the previous the --with-ssl is important if you plan on connecting to secure subversion repositories (such as what we use at unfuddle).

Now here's where it gets a little tricky. First you downloand and `configure` like you typically would the subversion binaries:

<pre lang="bash">
wget http://subversion.tigris.org/downloads/subversion-1.6.6.tar.gz
tar xzf subversion-1.6.6.tar.gz
cd subversion-1.6.6

./configure --with-ssl --with-neon=/usr/local
</pre>

But before you go ahead and issue the command `make` you need to edit the Makefile directly. <a href="http://blog.yimingliu.com/2009/05/27/subversion-162-runtime-error-on-network-access-on-os-x-105/">This post ultimately helped a lot</a>.

Search for the line that has the LDFLAGS variable assignment and change this to:

<pre lang="bash">
LDFLAGS =     -L/usr/local/lib -L/usr/lib $(EXTRA_LDFLAGS)
</pre>

Now continue on as you normally would:

<pre lang="bash">
make
make install
</pre>

And now you should be able to issue svn commands without a dreaded

<pre lang="bash">
dyld: lazy symbol binding failed: Symbol not found: _ne_set_connect_timeout
</pre>

Error.
