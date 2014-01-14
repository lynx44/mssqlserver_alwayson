#Chef::Log.info("cluster attribute: #{node['windows']['cluster']['name']}")
#Chef::Log.info("database attribute: #{node['mssqlserver']['alwayson']['database']}")
#Chef::Log.info("nodes attribute: #{node['mssqlserver']['alwayson']['nodes']}")

environment = node.chef_environment

primary_role = node['mssqlserver']['alwayson']['primary_role_name']
secondary_role = node['mssqlserver']['alwayson']['secondary_role_name']

Chef::Log.info("Primary Role Name: #{primary_role}")
Chef::Log.info("Secondary Role Name: #{secondary_role}")

nodes = GroupNodeCollection.new(node).get_nodes
Chef::Log.info("AlwaysOn Login Nodes: #{nodes}")

mssqlserver_alwayson_logins "create logins" do
  nodes nodes
end