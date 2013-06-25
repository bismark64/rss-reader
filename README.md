Feed Reader
==========

Simple Feed reader Rails app. 

It parses valid RSS/Atom feed, and shows them like Google Reader.

I used this gems:

    Rails = 3.2.9   
    Ruby = 1.9.3  
    RVM     
    PostgreSQL 
    Slim
    Twitter Bootstrap
    Devise
    Oauth
    Carrierwave
    Whenever
    Sunspot
    ActiveAdmin
    Cucumber
    Rspec
    Capistrano
    Unicorn

Notes:
------
Before runing the rails server in development, don't forget to start a Solr instance:

    bundle exec rake sunspot:solr:start 


