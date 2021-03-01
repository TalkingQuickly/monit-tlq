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

execute "restart-monit" do
  command "systemctl restart monit"
  command "monit reload"
  action :nothing
end
