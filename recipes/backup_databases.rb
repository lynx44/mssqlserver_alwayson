node['mssqlserver']['alwayson']['databases'].each do |db|
  mssqlserver_alwayson_database "backup #{db}" do
    database db
    file_path "#{node['mssqlserver']['alwayson']['backup_directory']}\\#{db}.bak"
    action :backup
  end
end