---
title: Tokyo Cabinet Install Ubuntu
date: '2009-11-19'
tags: tech
---

If you run into this error:

<pre lang="bash">
checking bzlib.h usability... no
checking bzlib.h presence... no
checking for bzlib.h... no
configure: error: bzlib.h is required
</pre>

It's because you need the bzlib devel package. On ubuntu, it's (obviously?) libbz2-dev:

<pre lang="bash">
sudo apt-get install libbz2-dev
</pre>

Then your ./configure might work a little better...

