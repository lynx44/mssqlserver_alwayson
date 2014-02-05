node['mssqlserver']['alwayson']['databases'].each do |db|
  mssqlserver_alwayson_database "restore #{db}" do
    database db
    file_path "#{node['mssqlserver']['alwayson']['backup_directory']}\\#{db}.bak"
    action :restore
  end
end