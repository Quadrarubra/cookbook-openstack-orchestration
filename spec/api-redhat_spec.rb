# encoding: UTF-8
require_relative 'spec_helper'

describe 'openstack-orchestration::api' do
  describe 'redhat' do
    let(:runner) { ChefSpec::SoloRunner.new(REDHAT_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) { runner.converge(described_recipe) }

    include_context 'orchestration_stubs'
    include_examples 'expect runs openstack orchestration common recipe'

    it 'installs heat api packages' do
      ['openstack-heat-api', 'python-heatclient'].each do |pkg|
        expect(chef_run).to upgrade_package pkg
      end
    end

    it 'starts heat api on boot' do
      expect(chef_run).to enable_service('openstack-heat-api')
    end
  end
end
