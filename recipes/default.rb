# install monit
package 'monit'

# update the main monit configuration file
template "/etc/monit/monitrc" do
  owner "root"
  group "root"
  mode "0700"
  source "monit-rc.erb"
  notifies :run, "execute[restart-monit]", :immediately
end

# disable traditional init.d way of starting monit
bash "disabling init.d script for monit" do
  user "root"
  code <<-EOC
    update-rc.d -f monit remove
  EOC
  #  /etc/init.d/monit stop
end

# Use upstart to manage monit
template '/etc/init/monit.conf' do
  owner "root"
  group "root"
  mode "0644"
  source "monit-upstart.conf.erb"
  notifies :run, "execute[restart-monit]", :immediately
end

# allow monit to startup
template '/etc/default/monit' do
  owner "root"
  group "root"
  mode "0644"
  source "allow-monit-start.erb"
  notifies :run, "execute[restart-monit]", :immediately
end

execute "restart-monit" do
  command "initctl reload-configuration"
  command "monit reload"
  action :nothing
end
