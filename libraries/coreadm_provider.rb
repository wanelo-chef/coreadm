class Chef
  class Provider
    # Provider for the coreadm Chef provider
    #
    # coreadm 'my-app' do
    #   ...
    # end
    #
    class Coreadm < Chef::Provider::LWRPBase
      include Chef::Mixin::ShellOut

      def load_current_resource
        @current_resource ||= ::Coreadm::Current.new
      end

      def action_update
        set_global
        set_per_process
        enable_cores
        disable_cores
      end

      private

      def set_global
        return if current_resource.global_pattern == new_resource.global_pattern
        shell_out("coreadm -g #{new_resource.global_pattern}")
      end

      def set_per_process
        return if current_resource.per_process_pattern == new_resource.per_process_pattern
        shell_out("coreadm -i #{new_resource.per_process_pattern}")
      end

      def enable_cores
        enablers = new_resource.enabled_cores - current_resource.enabled_cores
        return if enablers.empty?
        Chef::Log.info "enabling cores for #{enablers.join(', ')}"
        shell_out("coreadm #{coreadm_enable_options.join(' ')}")
      end

      def disable_cores
        disablers = new_resource.disabled_cores & current_resource.enabled_cores
        return if disablers.empty?
        Chef::Log.info "disabling cores for #{disablers.join(', ')}"
        shell_out("coreadm #{coreadm_disable_options.join(' ')}")
      end

      def coreadm_enable_options
        new_resource.coreadm_enabled_types.map do |opt|
          "-e #{opt}"
        end
      end

      def coreadm_disable_options
        new_resource.coreadm_disabled_types.map do |opt|
          "-d #{opt}"
        end
      end
    end
  end
end
