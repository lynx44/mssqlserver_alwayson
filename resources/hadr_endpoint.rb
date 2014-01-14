actions :create

attribute :nodes, :kind_of => Array

def initialize(*args)
  super
  @action = :create
end