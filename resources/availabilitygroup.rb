actions :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :path, :kind_of => String
attribute :availabilityreplica, :kind_of => Array
attribute :database, :kind_of => String

def initialize(*args)
  super
  @action = :create
end