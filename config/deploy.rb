set :user, "auapo"
set :password, "etaphi"
set :application, "auapo"
set :repository, "http://svn.auapo.org/auapo2"

role :web, "dev.auapo.org"
role :app, "dev.auapo.org"
role :db, "dev.auapo.org", :primary => true

set :deploy_to, "/home/auapo/dev.auapo.org"
set :use_sudo, false
set :restart_via, :run
set :checkout, "export" 


task :after_symlink, :roles => [:web, :app] do
		# Make dispatcher executable
    run "chmod a+x #{current_path}/public/dispatch.fcgi"
end

#desc "Restart the FCGI processes on the app server as a regular user."
task :restart, :roles => :app do
  run "ruby #{current_path}/script/process/reaper --dispatcher=dispatch.fcgi"
end