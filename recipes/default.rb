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
  databases node['mssqlserver']['alwayson']['databases']
  nodes allNodes
  action :create
end

if node['mssqlserver']['alwayson']['endpoint']['name'] != nil
  mssqlserver_alwayson_group_endpoint node['mssqlserver']['alwayson']['endpoint']['name'] do
    group_name node['mssqlserver']['alwayson']['name']
    ip_address node['mssqlserver']['alwayson']['endpoint']['ipaddress']
    mask       node['mssqlserver']['alwayson']['endpoint']['mask']
    port       node['mssqlserver']['alwayson']['endpoint']['port']
  end
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

allNodes.each do |current_node|
  mssqlserver_alwayson_read_only_routing_endpoint "create readonly routing endpoint for #{current_node['hostname']}" do
    availability_group node['mssqlserver']['alwayson']['name']
    node_name current_node['hostname']
    url "TCP://#{current_node['fqdn']}:1433"
  end
end

allNodes.each do |current_node|
  mssqlserver_alwayson_read_only_routing_list "create readonly routing list for #{current_node['hostname']}" do
      availability_group node['mssqlserver']['alwayson']['name']
      primary_node current_node['hostname']
      routing_list allNodes.map { |n| n['hostname'] }.select { |hostname| hostname != current_node['hostname'] }.push(current_node['hostname'])
      action :update
  end
end