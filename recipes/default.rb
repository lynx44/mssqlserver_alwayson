nodeCollection = GroupNodeCollection.new(node)
allNodes = nodeCollection.get_nodes
mssqlserver_alwayson_hadr_endpoint node.hostname do
  nodes allNodes
  action :create
end

mssqlserver_alwayson_health "create health endpoints" do
  nodes allNodes
  action :create
end

mssqlserver_alwayson_group node['mssqlserver']['alwayson']['name'] do
  database node['mssqlserver']['alwayson']['database']
  nodes allNodes
  action :create
end

mssqlserver_alwayson_group_endpoint node['mssqlserver']['alwayson']['endpoint']['name'] do
  group_name node['mssqlserver']['alwayson']['name']
  ip_address node['mssqlserver']['alwayson']['endpoint']['ipaddress']
  mask       node['mssqlserver']['alwayson']['endpoint']['mask']
  port       node['mssqlserver']['alwayson']['endpoint']['port']
end

nodesWithoutCurrent = nodeCollection.get_nodes_except_current
mssqlserver_alwayson_group node['mssqlserver']['alwayson']['name'] do
  name node['mssqlserver']['alwayson']['name']
  nodes nodesWithoutCurrent
  action :join
end

mssqlserver_alwayson_group node['mssqlserver']['alwayson']['name'] do
  name node['mssqlserver']['alwayson']['name']
  nodes nodesWithoutCurrent
  action :connect
end