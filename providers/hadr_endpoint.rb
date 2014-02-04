action :create do
  nodes = mapNodes()

  scriptPath = "#{Chef::Config[:file_cache_path]}\\CreateHadrEndpoint.sql"
  template scriptPath do
    source "CreateHadrEndpoint.sql.erb"
    variables({
         "nodes" => nodes,
         "logon_username" => service.logon_username,
         "uses_system_account" => service.uses_system_account
     })
  end

  mssqlserver_sql_command "create hadr endpoint" do
    script scriptPath
    database "master"
  end
end

def mapNodes
  @new_resource.nodes.map { |n| GroupNode.new(n) }
end

def service
  @service ||= AlwaysOn::SqlServerService.new
end