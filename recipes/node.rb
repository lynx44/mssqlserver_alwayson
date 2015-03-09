::Chef::Recipe.send(:include, Windows::RegistryHelper)

windows_firewall_rule "SQL Server" do
  localport "1433"
end

alwaysOnInstalled = false
begin
  registryValues = get_values('HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQLServer\HADR')
  hadr_enabled = registryValues.select{|r|  r[0] == "HADR_Enabled"}.first()
  alwaysOnInstalled = hadr_enabled != nil && hadr_enabled[2] == 1
rescue #key does not exist
  alwaysOnInstalled = false
end

notString = alwaysOnInstalled ? nil : 'not '
Chef::Log.info("AlwaysOn is currently #{notString}installed");

powershell "enable alwayson" do
  code <<-EOH
    Import-Module "SQLPS"
    Enable-SqlAlwaysOn -ServerInstance localhost -Force
  EOH
  not_if { alwaysOnInstalled }
  notifies :restart, "service[MSSQLSERVER]", :delayed
end

service "MSSQLSERVER" do
  action :nothing
end
