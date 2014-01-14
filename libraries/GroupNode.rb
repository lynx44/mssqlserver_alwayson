class GroupNode
  attr_reader :hostname, :domain, :port, :failover_mode, :availability_mode, :backup_priority, :allow_connections

  def initialize(struct)
    @struct = struct
    @hostname = @struct['hostname']
    @domain = @struct['domain']
    @port = get_attribute('mssqlserver', 'alwayson', 'port') || 5022
    @failover_mode = get_attribute('mssqlserver', 'alwayson', 'failover_mode') || 'automatic'
    @availability_mode = get_attribute('mssqlserver', 'alwayson', 'availability_mode') || 'SYNCHRONOUS_COMMIT'
    @backup_priority = get_attribute('mssqlserver', 'alwayson', 'backup_priority') || 50
    @allow_connections = get_attribute('mssqlserver', 'alwayson', 'allow_connections') || 'ALL'
  end

  def get_attribute(*args)
    value = @struct
    args.each_with_index do |arg, index|
      if (value[args[index]] == nil) then
        return nil
      else
        value = value[args[index]]
      end
    end
    value
  end
end