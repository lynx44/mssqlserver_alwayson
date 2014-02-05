actions :backup, :restore
default_action :backup

attribute :file_path, :kind_of => String
attribute :database, :kind_of => String