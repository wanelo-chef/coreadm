require 'chef/mixin/shell_out'

module Coreadm
  # Coreadm::Current
  #
  # Look up current settings in coreadm
  #
  class Current
    include Chef::Mixin::ShellOut

    def global_pattern
      current_settings['global core file pattern']
    end

    def global_content
      current_settings['global core file content']
    end

    def init_pattern
      current_settings['init core file pattern']
    end

    def init_content
      current_settings['init core file content']
    end

    def global_cores_enabled?
      current_settings['global core dumps'] == 'enabled'
    end

    def per_process_cores_enabled?
      current_settings['per-process core dumps'] == 'enabled'
    end

    def global_setid_cores_enabled?
      current_settings['global setid core dumps'] == 'enabled'
    end

    def per_process_setid_cores_enabled?
      current_settings['per-process setid core dumps'] == 'enabled'
    end

    def global_cores_logged?
      current_settings['global core dump logging'] == 'enabled'
    end

    private

    def current_settings
      @settings ||= shell_out('coreadm').stdout.split("\n")
                    .each_with_object({}) do |line, s|
        name, setting = line.strip.split(': ')
        s[name] = setting
      end
    end
  end
end
