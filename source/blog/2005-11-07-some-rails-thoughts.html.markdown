---
title: Some Rails Thoughts
date: '2005-11-07'
tags: tech
---

<p>So I've been doing some work with Ruby on Rails lately and I have to say that so far  I've really enjoyed working with the language.  I think that a lot of the articles out there saying it's the greatest thing since sliced bread are a bit over-hyped, but I do have to say that it certainly helps to fill a gap in the proverbial tech `toolbox` that, to me, has been missing for some time now.</p>
<p>For a long time I was a Java purist, and I enjoyed writing custom applications in the language - though my work was generally limited to server-side applications that had little to no end-user interface.  After several projects trying to build custom intranet applications with JSP and Struts I found that I was spending an inordinate amount of time in the GUI layer (partly due to my own shortcomings, but also partly due to the shortcomings of the technology stack I was working with).</p>
<p>Rails has increased my productivity -- <b>a lot</b>.  <i>But...</i> only in certain circumstances.  Namely, I've found it particularly useful when doing simple CRUD (<u>C</u>reate, <u>R</u>ead, <u>U</u>pdate, <u>D</u>elete) functionality.  If my object model gets too complex, or the server-side logic becomes more `process-like` I find myself wishing I was back in Java-land.  If I just want to expose a database table's contents on a page, or if I want to give a client some sort of management page where they can modify various simple business entities, then Rails saves a tremendous amount of time and energy.</p>
<p>So basically what I'm saying is that Rails isn't a panacea (yet, or especially for me).  But for a lot of people that have very simple persistent data needs than it's a wonderful accelerant and dovetails nicely into an existing web based architecture without having to provide a servlet engine, etc., etc.</p>
