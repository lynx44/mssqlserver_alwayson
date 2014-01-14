action :create do
  nodes = mapNodes()

  scriptPath = "#{Chef::Config[:file_cache_path]}\\CreateHadrEndpoint.sql"
  template scriptPath do
    source "CreateHadrEndpoint.sql.erb"
    variables({
         "nodes" => nodes
     })
  end

  mssqlserver_sqlcommand "create hadr endpoint" do
    script scriptPath
    database "master"
  end
end

def mapNodes
  @new_resource.nodes.map { |n| GroupNode.new(n) }
end