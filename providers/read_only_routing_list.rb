action :update do
  template script_path do
    source 'ReadOnlyRoutingList.sql.erb'
    variables({
      :availability_group => self.availability_group,
      :primary_node => self.primary_node,
      :routing_list => self.routing_list
    })
  end

  mssqlserver_sql_command "run read-only routing list script on #{node['primary_node']}" do
    script script_path
    database 'master'
  end
end

def script_path
  "#{Chef::Config[:file_cache_path]}\\ReadOnlyRoutingList.sql"
end

def availability_group
  @new_resource.availability_group
end

def primary_node
  @new_resource.primary_node
end

def routing_list
  @new_resource.routing_list.map { |n| "'#{n}'" }.join(',')
end