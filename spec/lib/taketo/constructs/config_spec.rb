require 'spec_helper'

module Taketo::Constructs

  describe Config do
    subject(:config) { Config.new }

    it "allows only groups, projects and servers as children" do
      config.allowed_node_types.should =~ [:project, :group, :server, :shared_server_config]
    end

    it { should have_accessor(:default_destination) }

    context "shared server configs" do
      let(:shared_server_config) do
        ::Taketo::Support::ServerConfig.new do |c|
          c.username = "root"
        end
      end

      it "has shared server configs" do
        config.add_shared_server_config(:foo, shared_server_config)
        expect(config.shared_server_config(:foo).username).to eq("root")
      end

      it "does not add shared server config with same name" do
        config.add_shared_server_config(:foo, shared_server_config)

        expect do
          config.add_shared_server_config(:foo, shared_server_config.dup)
        end.to raise_error(::Taketo::DuplicateSharedServerConfigError, /foo/)
      end

      it "raises if trying to get non-existent shared server config" do
        expect do
          config.shared_server_config(:bar)
        end.to raise_error(::Taketo::SharedServerConfigNotFoundError)
      end
    end

  end

end

