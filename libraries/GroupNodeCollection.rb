class GroupNodeCollection
  def initialize(node_attributes, search_method=nil, logger=nil)
    @node = node_attributes
    @logger = logger || Chef::Log
    @search_method = search_method
  end

  def get_nodes
    environment = @node.chef_environment
    primary_role = @node['mssqlserver']['alwayson']['primary_role_name']
    secondary_role = @node['mssqlserver']['alwayson']['secondary_role_name']
    @logger.info("Primary Role: #{primary_role}")
    @logger.info("Secondary Role: #{secondary_role}")
    search_string = "(role:#{primary_role} OR role:#{secondary_role}) AND chef_environment:#{environment}"
    @logger.info("Searching for: #{search_string}")
    nodes = search(:node, search_string)
    primary_nodes = search(:node, "role:#{primary_role} AND chef_environment:#{environment}")
    secondary_nodes = search(:node, "role:#{secondary_role} AND chef_environment:#{environment}")

    @logger.info("Found Nodes: #{nodes}")
    @logger.info("Found Primary Nodes: #{primary_nodes}")
    @logger.info("Found Secondary Nodes: #{secondary_nodes}")

    nodes
  end

  def get_nodes_except_current
    @logger.info("Running Node: #{@node}")
    hostname = @node['hostname']
    @logger.info("Running hostname: #{hostname}")
    @logger.info("Running hostname: #{hostname}")
    nodes = get_nodes
    @logger.info("Found Nodes: #{nodes}")
    @logger.info(Chef::Config[:chef_server_url])
    nodes.select { |n| n['hostname'] != hostname }
  end

  def search(type, query="*:*")
    @query ||= Chef::Search::Query.new()
    @query.search(type, query)[0]
  end
end