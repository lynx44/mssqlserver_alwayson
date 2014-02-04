actions :create
default_action :create

attribute :nodes, :kind_of => Array #array of GroupNode objects
attribute :service_username, :kind_of => String