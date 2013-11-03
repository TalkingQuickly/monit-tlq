# install monit
package 'monit'

# update the main monit configuration file
template "/etc/monit/monitrc" do
  owner "root"
  group "root"
  mode "0700"
  source "monit-rc.erb"
end

# disable traditional init.d way of managing monit
bash "disabling init.d script for monit" do
  user "root"
  code <<-EOC
/etc/init.d/monit stop
update-rc.d -f monit remove
  EOC
end

# Use upstart to manage monit
template '/etc/init/monit.conf' do
  owner "root"
  group "root"
  mode "0644"
  source "monit-upstart.conf.erb"
end

# allow monit to startup
template '/etc/default/monit' do
  owner "root"
  group "root"
  mode "0644"
  source "allow-monit-start.erb"
end

execute "initctl reload-configuration"

execute "service monit restart"
