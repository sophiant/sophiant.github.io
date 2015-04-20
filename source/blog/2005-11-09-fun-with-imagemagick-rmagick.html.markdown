---
title: Fun With ImageMagick / RMagick
date: '2005-11-09'
tags: tech
---

<p>So I've been having some trying to get ImageMagick and RMagick (the ruby bindings to ImageMagick) installed on my server for a while now.  If you've ever had a similar problem here's a few gotchas that I encountered.</p>
<p>First off before installing ImageMagick be sure that you have the delegate libraries of the file formats that you wish to convert already installed.  An example would be libjpeg for JPEG images.  This FAQ tells you <a href="http://rmagick.rubyforge.org/install-faq.html#imprereq">
what delegates are required</a> and provides links to the libraries to build on your machine.  Once they are set up you can download the ImageMagick source and then build is fairly straightforward.</p>
<!--more-->
<p>I had real problems with the libjpeg source in particular.  The ImageMagick build requires the libjpeg.h file, but the libjpeg build doesn't install the source by default when doing make install.  <a href="http://channels.lockergnome.com/linux/archives/20030718_compiling_software_from_source_part_iv.phtml">This forum post helped me out</a>, and invoking the command 'make install-lib' did the trick for me.</p>
<p>Now I also have a 64-bit linux distribution (sigh...) and upon finally figuring out the little make install-lib trick on the jpeg delegate library, I am now getting '/usr/local/lib/libjpeg.a: could not read symbols: Bad value'.  Will post an update when I get through this.</p>
<p>And all I wanted to do is resize some .jpeg images that are uploaded on the fly to a thumbnail.  Who knew it would be such a pain!  (caveat here: my hosted server works seamlessly, they've already got ImageMagick and RMagick installed and working great.  I'm just trying to be a nice person and not do my development on their shared hosting machine, so I'm trying to set up a local server to emulate the same environment.  Sometimes being a developer and an admin at the same time is a burden.</p>
<h3>Update!</h3>
<p>It Works!  Man libjpeg install was a mess.  Tried a bunch of combinations of --enable-shared, etc., etc. on the ./configure commands for both libjpeg and ImageMagick builds.  What it came down to was to pass the special CFLAGS=-fpic to the make command when building libjpeg, i.e. 'make CFLAGS=-fpic'.  I got the <a href="http://www.directadmin.com//forum/showthread.php?s=0b60f592579fdf7bfc9b19c9cd93e17e&postid=51923">inspiration here.</a>
