require 'taketo/config_visitor'
require 'taketo/printer'
require 'pry'

module Taketo
  class GroupListVisitor < SimpleCollector(Constructs::Server)
    def result
      @result.map do |res|
        gl_alias = res.global_alias
        gl_alias.to_s == '' ? res.path : "#{res.path}:#{res.global_alias.red}"
      end.join("\n")
    end
  end
end
