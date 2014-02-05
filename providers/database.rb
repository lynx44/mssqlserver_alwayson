action :backup do
  description = @new_resource.name
  file_path = @new_resource.file_path
  database_name = @new_resource.database
  mssqlserver_backup_database description do
    destination file_path
    database database_name
    with ['COPY_ONLY', 'FORMAT', 'INIT', 'SKIP', 'REWIND', 'NOUNLOAD', 'COMPRESSION',  'STATS = 5']
  end
end

action :restore do
  description = @new_resource.name
  db_file_path = @new_resource.file_path
  database_name = @new_resource.database
  mssqlserver_restore_database description do
    file_path db_file_path
    database database_name
    with ['NORECOVERY',  'NOUNLOAD',  'STATS = 5']
  end
end