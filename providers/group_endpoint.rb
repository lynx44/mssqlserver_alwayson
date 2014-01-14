action :create do
  scriptPath = "#{Chef::Config[:file_cache_path]}\\CreateAvailabilityGroupEndpoint.sql"

  group_name = @new_resource.group_name
  listener_name = @new_resource.listener_name
  ip_address = @new_resource.ip_address
  mask = @new_resource.mask
  port = @new_resource.port

  template scriptPath do
    source "CreateAvailabilityGroupEndpoint.sql.erb"
    variables({
                  "server" => node['hostname'],
                  "group_name" => group_name,
                  "listener_name" => listener_name,
                  "ip_address" => ip_address,
                  "mask" => mask,
                  "port" => port
              })
  end

  mssqlserver_sqlcommand "create availability group" do
    script scriptPath
    database "master"
  end
end