require 'taketo/node_resolver'
require 'taketo/constructs/server'

module Taketo

  class ServerResolver < NodeResolver
    def nodes
      super.select { |n| Taketo::Constructs::Server === n }
    end
    alias :servers :nodes

    def resolve
      resolve_by_global_alias || resolve_by_path
    end

    def resolve_by_global_alias
      return if @path.to_s.empty?
      servers_with_global_alias = servers.select(&:global_alias)
      list = @path.split(",").map do |local_path|
        servers_with_global_alias.find { |s| s.global_alias == local_path }
      end.compact
      list.count > 1 ? list : list.first
    end

    def resolve_by_path
      list = @path.split(",").map do |local_path|
        servers.find { |s| s.global_alias == local_path }
        matching_servers = servers.select { |s| s.path =~ /^#@path/ }
        disambiguate(matching_servers)
      end.flatten.compact
      list.count > 1 ? list : list.first
    end

    def disambiguate(results)
      case results.length
      when 0
        raise NonExistentDestinationError, "Can't find such destination: #@path"
      when 1
        results.first
      else
        exact_match = results.detect { |n| n.path == @path }
        return exact_match if exact_match
        puts "There are multiple possible destinations: #{results.map(&:path).join(", ")}".yellow
        results
      end
    end
  end
end
