require 'taketo/commands'
require 'taketo/actions/base_action'
require 'taketo/server_resolver'

module Taketo
  module Actions

    class Login < BaseAction
      def run
        servers = ServerResolver.new(config, destination_path).resolve
        if servers.is_a?(Array) && options[:command]
          if options[:parallel]
            servers.map do |server|
              Thread.new do
                run_cmd(server)
              end
            end.each(&:join)
          else
            servers.each(&method(:run_cmd))
          end
        else
          run_cmd(servers.is_a?(Array) ? servers.first : servers)
        end
      end

      private

      def run_cmd(server)
        server_command = remote_command(server)
        command_to_execute = Commands[server.ssh_command].new(server).render(server_command.render(server, options))
        execute(command_to_execute)
      end

      def remote_command(server)
        command = options[:command]
        if String(command).empty?
          server.default_command
        else
          server.find_command(command.to_sym) || Constructs::Command.explicit_command(command)
        end
      end

      def execute(shell_command)
        if options[:dry_run]
          puts shell_command
        else
          system shell_command
        end
      end
    end

  end
end

