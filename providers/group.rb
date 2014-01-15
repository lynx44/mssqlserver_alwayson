action :create do
  groupNodes = mapNodes()
  Chef::Log.info("nodes: #{groupNodes}");
  name = @new_resource.name
  automated_backup_preference = @new_resource.automated_backup_preference
  database = @new_resource.database

  scriptPath = "#{Chef::Config[:file_cache_path]}\\CreateAvailabilityGroup.sql"
  template scriptPath do
    source "CreateAvailabilityGroup.sql.erb"
    variables({
                  "server" => node['hostname'],
                  "database" => database,
                  "name" => name,
                  "automated_backup_preference" => automated_backup_preference,
                  "nodes" => groupNodes
              })
  end

  mssqlserver_sql_command "create availability group" do
    script scriptPath
    database "master"
  end
end

action :connect do
  name = @new_resource.name
  database = @new_resource.database
  nodes = mapNodes()
  scriptPath = "#{Chef::Config[:file_cache_path]}\\ConnectToGroup.sql"
  template scriptPath do
    source "ConnectToGroup.sql.erb"
    variables({
                  "nodes" => nodes,
                  "name" => name,
                  "database" => database
              })
  end

  mssqlserver_sql_command "connect to availability group" do
    script scriptPath
    database "master"
  end
end

action :join do
  name = @new_resource.name
  nodes = mapNodes()
  scriptPath = "#{Chef::Config[:file_cache_path]}\\JoinAvailabilityGroup.sql"
  template scriptPath do
    source "JoinAvailabilityGroup.sql.erb"
    variables({
                  "nodes" => nodes,
                  "name" => name
              })
  end

  mssqlserver_sql_command "join availability group" do
    script scriptPath
    database "master"
  end
end

action :destroy do
  name = @new_resource.name

  scriptPath = "#{Chef::Config[:file_cache_path]}\\DestroyAvailabilityGroup.sql"
  template scriptPath do
    source "DestroyAvailabilityGroup.sql.erb"
    variables({
                  "name" => name
              })
  end

  mssqlserver_sql_command "destroy availability group" do
    script scriptPath
    database "master"
  end
end

def mapNodes
  @new_resource.nodes.map { |n| GroupNode.new(n) }
end