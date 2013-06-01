Undertow Web Site
=================

Installing the tool-chain
--------------------------
1. Install Ruby with using (RVM)[http://rvm.io] (Awestruct likely won't function otherwise)
2. Clone the repo 
   git clone git@github.com:undertow/undertow-io-site
3. Install Gems
   bundle install

Developing Changes
-------------------
1. Run awestruct developer mode
   bundle exec awestruct -d
2. Make changes
3. Point browser to http://localhost:4242

Deploying Changes
-----------------
1. Make sure everything has been committed and pushed to github
2. Run deploy command
   ./deploy.sh
3. Point browser to http://undertow.io

