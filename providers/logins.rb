action :create do
  scriptPath = "#{Chef::Config[:file_cache_path]}\\Logins.sql"
  template scriptPath do
    source 'Logins.sql.erb'
    variables({
                  "logins" => logins
              })
  end

  mssqlserver_sql_command 'create server logins' do
    script scriptPath
    database "master"
  end
end

def service
  @service ||= AlwaysOn::SqlServerService.new
end

def logins
  @logins = [service.logon_username]
  if service.uses_system_account
    @logins = nodes.map { |n| "#{n.domain.split('.')[0].upcase}\\#{n.hostname}$" }
  end
  @logins
end

def nodes
  servers = @new_resource.nodes
  Chef::Log.info("nodes: #{servers}")
  @groupNodes ||= servers.map{ |n| GroupNode.new(n) }.select{ |n| n.hostname && n.domain && n.hostname != node['hostname'] }
end