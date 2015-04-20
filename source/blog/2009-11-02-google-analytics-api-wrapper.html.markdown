---
title: Google Analytics API Wrapper
date: '2009-11-02'
tags: tech
---

I wrote this simple class last Friday as part of what was supposed to be my skunkworks day (I only got 20 minutes to myself... sigh). Time management for another post! In any event, I was messing around with the Google Analytics API - the majority of my company's domains use this app and that it would be good to prototype some functionality that could go grab visitors and bounces, could parse the responses and throw the result into an XML format that our Fusion Charts software could then display. Here's some mocked up code that could get you started.

<!--more-->

<pre lang="ruby">
require 'rubygems'
require 'httparty'

class GoogleAnalytics
  include HTTParty
  base_uri 'https://www.google.com/analytics/feeds'

  class << self
    attr_accessor :auth
  end

  def self.login(email, password)
    result = post("https://www.google.com/accounts/ClientLogin", :query => {:accountType => 'GOOGLE', :Email => email, :Passwd => password, :service=> 'analytics', :source => '<< your company >>-<< your app name >>-<< some unique version >>'}, :body => '')
    self.auth = result.include?('Auth=') ? result.split("\n").last.split('=').last : ""
  end

  def self.accounts
    get("/accounts/default",{:format => :xml, :headers => authorization})
  end

  #
  # GoogleAnalytics.data(:query => { :ids => "ga:<< your google analytics id>>", :metrics => "ga:visits,ga:bounces", 'start-date' => "2009-10-01", 'end-date' => "2009-10-31" })
  #
  def self.data(options = {})
    options.merge!({:format => :xml, :headers => authorization})
    get("/data",options)
  end

  def self.authorization
    {'Authorization' => "GoogleLogin auth=#{self.auth}"}
  end

end
</pre>

I didn't get the response body back to compatible fusion charts done, but the HTTParty works great.
