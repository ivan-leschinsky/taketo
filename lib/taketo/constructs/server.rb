require 'taketo/support'

module Taketo
  module Constructs

    class Server < BaseConstruct
      attr_reader :environment_variables
      attr_accessor :ssh_command, :host, :port, :username, :default_location,
                    :default_command, :global_alias, :identity_file, :other_options

      has_nodes :commands, :command

      def initialize(name)
        super
        @environment_variables = {}
        @ssh_command = :ssh
      end

      def env(env_variables)
        @environment_variables.merge!(env_variables)
      end

      def parent=(parent)
        super
        env(:RAILS_ENV => parent.rails_env) if parent.respond_to?(:rails_env)
      end

      def ssh_command=(ssh_command)
        @ssh_command = ssh_command.to_sym
      end

      def global_alias=(alias_name)
        @global_alias = alias_name.to_s
      end

      def default_command
        if defined? @default_command
          find_command(@default_command) || Command.explicit_command(@default_command)
        else
          Command.default
        end
      end
    end

  end
end

