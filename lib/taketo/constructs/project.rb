require 'taketo/support'

module Taketo
  module Constructs

    class Project < BaseConstruct
      has_nodes :environments, :environment
      has_nodes :servers, :server
      has_nodes :groups, :group

      def has_servers?
        has_deeply_nested_nodes?(:servers)
      end
    end

  end
end

