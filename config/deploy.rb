set :application, "Rails3Depot"
set :repository,  "clint@ctshryock.com:webapps/git/repos/rails3.git"
set :deploy_to, "/home/clint/webapps/depot/depot_app"

set :deploy_via, :remote_cache

set :scm, 'git'
set :branch, 'master'
set :use_sudo, false
set :keep_releases, 4
server 'depot.catsby.net', :app, :web, :db, :primary => true

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "your app-server here"                          # This may be the same as your `Web` server
role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  desc "reload the database with seed data"
  task :seed do
    rn "cd #{current_path}; rake db:seed RAILS_ENV=production"
  end
end



# cleanup
after "deploy:update", "deploy:cleanup"

# update gems

after "deploy:update_code", :bundle_install
desc "install the necessary prerequisites"
task :bundle_install, :roles => :app do
  run "cd #{release_path} && bundle install"
end
