action :create do
  nodes = mapNodes()

  scriptPath = "#{Chef::Config[:file_cache_path]}\\CreateHealth.sql"
  template scriptPath do
    source "CreateHealth.sql.erb"
    variables({
                  "nodes" => nodes
              })
  end

  mssqlserver_sql_command "create health" do
    script scriptPath
    database "master"
  end
end

def mapNodes
  @new_resource.nodes.map { |n| GroupNode.new(n) }
end