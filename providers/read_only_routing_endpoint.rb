action :update do
  template script_path do
    source 'ReadOnlyRoutingEndpoint.sql.erb'
    variables({
        :availability_group => self.availability_group,
        :node_name => self.node_name,
        :url => self.url
    })
  end

  mssqlserver_sql_command "run read-only routing endpoint script for #{node['secondary_node']}" do
    script script_path
    database 'master'
  end
end

def script_path
  "#{Chef::Config[:file_cache_path]}\\ReadOnlyRoutingEndpoint.sql"
end

def availability_group
  @new_resource.availability_group
end

def node_name
  @new_resource.node_name
end

def url
  @new_resource.url
end