require 'spec_helper'
require 'libraries/current'

RSpec.describe 'coreadm provider' do
  let(:helper) { Coreadm::Current.new }

  it 'sets global pattern' do
    expect(helper.global_pattern).to eq('/var/core/global.core.%p')
  end

  it 'sets init pattern' do
    expect(helper.per_process_pattern).to eq('/var/core/init.core.%p')
  end

  it 'enables each specified type' do
    expect(helper.global_cores_enabled?).to be false
    expect(helper.per_process_cores_enabled?).to be true
    expect(helper.global_setid_cores_enabled?).to be true
    expect(helper.per_process_setid_cores_enabled?).to be true
  end
end
