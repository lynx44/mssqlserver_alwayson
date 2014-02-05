node['mssqlserver']['alwayson']['databases'].each do |db|
  mssqlserver_alwayson_transaction_log "backup #{db} transaction log" do
    database db
    file_path "#{node['mssqlserver']['alwayson']['backup_directory']}\\#{db}.trn"
    action :backup
  end
end