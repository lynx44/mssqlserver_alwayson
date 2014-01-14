actions :create

attribute :listener_name, :kind_of => String, :name_attribute => true #usually the same name as the database
attribute :group_name, :kind_of => String #availability group name
attribute :ip_address, :kind_of => String
attribute :mask, :kind_of => String
attribute :port, :kind_of => Integer

def initialize(*args)
  super
  @action = :create
end
