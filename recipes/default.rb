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

file '/etc/init/monit.conf' do
  owner "root"
  group "root"
  mode "0644"
  content <<-EOF

# after adding this file run
#   initctl reload-configuration
#
# You can manually start and stop monit like this:
#
# start monit
# stop monit
#

description "Monit service manager"

limit core unlimited unlimited

start on runlevel [2345]
stop on runlevel [!2345]

expect daemon
respawn

exec /usr/bin/monit -c /etc/monit/monitrc

pre-stop exec /usr/bin/monit -c /etc/monit/monitrc quit
  EOF
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
