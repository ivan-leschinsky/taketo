module Taketo

  module Commands
    autoload :SSHOptions,  'taketo/commands/ssh_options'
    autoload :SSHCommand,  'taketo/commands/ssh_command'
    autoload :MoshCommand, 'taketo/commands/mosh_command'

    class CommandNotFoundError < StandardError; end

    def self.[](name)
      commands_map = {
        :ssh  => SSHCommand,
        :mosh => MoshCommand,
      }
      commands_map.fetch(name) do
        raise CommandNotFoundError,
          "Command #{name.inspect} not found. Available commands are: #{commands_map.keys.join(", ")}"
      end
    end
  end

end

