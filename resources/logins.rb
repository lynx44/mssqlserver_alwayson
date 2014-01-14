actions :create

attribute :nodes, :kind_of => Array #array of GroupNode objects

def initialize(*args)
  super
  @action = :create
end