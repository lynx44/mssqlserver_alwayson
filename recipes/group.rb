#mssqlserver_alwayson_group node['mssqlserver']['alwayson']['group']['name'] do
#  database node['mssqlserver']['alwayson']['group']['database']
#  nodes node['mssqlserver']['alwayson']['group']['nodes']
#  action :create
#end
#
#mssqlserver_alwayson_group_endpoint node['mssqlserver']['alwayson']['group']['endpoint']['name'] do
#  group_name node['mssqlserver']['alwayson']['group']['name']
#  ip_address node['mssqlserver']['alwayson']['group']['endpoint']['ipaddress']
#  mask       node['mssqlserver']['alwayson']['group']['endpoint']['mask']
#  port       node['mssqlserver']['alwayson']['group']['endpoint']['port']
#end
#


windows_firewall_rule "alwayson hadr endpoint" do
  port 5022
end

mssqlserver_alwayson_logins "create logins" do
  nodes node['mssqlserver']['alwayson']['group']['nodes']
end

#mssqlserver_alwayson_group node['mssqlserver']['alwayson']['group']['name'] do
#  action :join
#end
#
#mssqlserver_alwayson_group node['mssqlserver']['alwayson']['group']['name'] do
#  action :connect
#end