actions :create, :connect, :join

attribute :name, :kind_of => String, :name_attribute => true
attribute :database, :kind_of => String
attribute :automated_backup_preference, :kind_of => Symbol, :equal_to => [:Secondary], :default => :Secondary
attribute :nodes, :kind_of => Array #array of GroupNode objects

def initialize(*args)
  super
  @action = :create
end