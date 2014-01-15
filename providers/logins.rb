action :create do
  nodes = @new_resource.nodes
  Chef::Log.info("nodes: #{nodes}")
  groupNodes = nodes.map{ |n| GroupNode.new(n) }.select{ |n| n.hostname && n.domain && n.hostname != node['hostname'] }

  if groupNodes.length > 0
    scriptPath = "#{Chef::Config[:file_cache_path]}\\Logins.sql"
    template scriptPath do
      source "Logins.sql.erb"
      variables({
                    "nodes" => groupNodes
                })
    end

    mssqlserver_sql_command "create server logins" do
      script scriptPath
      database "master"
    end
  end
end