Rss Reader
==========

Notes:
------

I have used Cucumber to make BDD, but it was my first time.. 
So please be patient if you see not too good code in the test..

Before runing the rails server in development, don't forget to start the Solr instance:

    bundle exec rake sunspot:solr:start 

then you can start the server as usual.


Capistrano instructions:
------------------------

This app already includes the Capfile and deploy.rb files needed for deploy.
Please check this files, since there are some placeholders such the deploy directory, the :web, :app, :db roles, etc..
To make it work in a real production server, you must to provide real values for this placeholders, 
and take care to run gems related tasks (such Sunspot or Whenever) to run succesfully the app.
