actions :create, :connect, :join, :destroy
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :databases, :kind_of => Array
attribute :automated_backup_preference, :kind_of => Symbol, :equal_to => [:Secondary], :default => :Secondary
attribute :nodes, :kind_of => Array #array of GroupNode objects