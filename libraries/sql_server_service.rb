module AlwaysOn
  class SqlServerService
    def initialize

    end

    def logon_username
      shell_output = run_shell('sc qc MSSQLSERVER')
      @logon_username ||= /SERVICE_START_NAME[\s]+:[\s]+(?<name>.+)$/.match(shell_output)['name'].strip
    end

    def uses_system_account
      ['LocalSystem', 'NT AUTHORITY\NetworkService'].any? { |u| u == logon_username }
    end

    private
    def run_shell(command)
      shell_out = Chef::Mixlib::ShellOut.new(command)
      shell_out.run_command
      shell_out.stdout
    end
  end
end
