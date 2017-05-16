module Taketo
  module Commands
    class SSHCommand
      include SSHOptions

      def initialize(server, _options = {})
        @server = server
      end

      def render(rendered_command)
        final_command = "#{program} #{port} "\
                        "#{identity_file} #{username}#{host} "\
                        "#{other_options} \"#{rendered_command}\"".squeeze(' ')
        p "Running: #{final_command}" if ENV['DEBUG']
        final_command
      end

      def program
        'ssh -t'
      end
    end
  end
end
