require 'spec_helper'
require 'libraries/current'

RSpec.describe Coreadm::Current do
  subject(:current) { Coreadm::Current.new }

  before do
    coreadm_response = double('coreadm')
    allow(current).to receive(:shell_out).with('coreadm') { coreadm_response }
    allow(coreadm_response).to receive(:stdout) do
      "     global core file pattern: /var/core/global/core.%f.%p.%t\n" \
      "     global core file content: global content\n" \
      "       init core file pattern: /var/core/init/core.%f.%p\n" \
      "       init core file content: init content\n" \
      "            global core dumps: enabled\n" \
      "       per-process core dumps: enabled\n" \
      "      global setid core dumps: disabled\n" \
      " per-process setid core dumps: enabled\n" \
      "     global core dump logging: disabled\n"
    end
  end

  describe '#global_pattern' do
    it 'matches pattern from coreadm' do
      expect(current.global_pattern).to eq('/var/core/global/core.%f.%p.%t')
    end
  end

  describe '#global_content' do
    it 'matches content from coreadm' do
      expect(current.global_content).to eq('global content')
    end
  end

  describe '#per_process_pattern' do
    it 'matches content from coreadm' do
      expect(current.per_process_pattern).to eq('/var/core/init/core.%f.%p')
    end
  end

  describe '#per_process_content' do
    it 'matches content from coreadm' do
      expect(current.per_process_content).to eq('init content')
    end
  end

  describe '#global_cores_enabled?' do
    it 'matches content from coreadm' do
      expect(current.global_cores_enabled?).to be true
    end
  end

  describe '#per_process_cores_enabled?' do
    it 'matches content from coreadm' do
      expect(current.per_process_cores_enabled?).to be true
    end
  end

  describe '#global_setid_cores_enabled?' do
    it 'matches content from coreadm' do
      expect(current.global_setid_cores_enabled?).to be false
    end
  end

  describe '#per_process_setid_cores_enabled?' do
    it 'matches content from coreadm' do
      expect(current.per_process_setid_cores_enabled?).to be true
    end
  end

  describe '#global_cores_logged??' do
    it 'matches content from coreadm' do
      expect(current.global_cores_logged?).to be false
    end
  end

  describe '#enabled_cores' do
    it 'maps enabled cores to symbols' do
      expect(current.enabled_cores).to match_array([:global, :per_process, :per_process_setid])
    end
  end
end
