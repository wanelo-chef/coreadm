class Chef
  class Resource
    # Resource for the coreadm Chef provider
    #
    # coreadm 'my-app' do
    #   ...
    # end
    #
    class Coreadm < Chef::Resource
      attr_reader :enabled_cores, :disabled_cores

      TYPES = [:global, :per_process, :global_setid, :per_process_setid].freeze

      def initialize(name, run_context = nil)
        super
        @resource_name = :coreadm
        @provider = Chef::Provider::Coreadm
        @action = :update
        @allowed_actions = [:update]
        @enabled_cores = []
        @disabled_cores = []
      end

      def name(arg = nil)
        set_or_return(:name, arg, kind_of: String)
      end

      def global_pattern(arg = nil)
        set_or_return(:global_pattern, arg, kind_of: String)
      end

      def per_process_pattern(arg = nil)
        set_or_return(:init_pattern, arg, kind_of: String)
      end

      def global_content(arg = nil)
        set_or_return(:global_content, arg, kind_of: String)
      end

      def per_process_content(arg = nil)
        set_or_return(:per_process_content, arg, kind_of: String)
      end

      def enable(*types)
        types.each { |t| validate_type(t) }
        @enabled_cores += types
      end

      def disable(*types)
        types.each { |t| validate_type(t) }
        @disabled_cores += types
      end

      def coreadm_enabled_types
        [].tap do |types|
          types << 'global' if enabled_cores.include?(:global)
          types << 'global-setid' if enabled_cores.include?(:global_setid)
          types << 'process' if enabled_cores.include?(:per_process)
          types << 'proc-setid' if enabled_cores.include?(:per_process_setid)
        end
      end

      def coreadm_disabled_types
        [].tap do |types|
          types << 'global' if disabled_cores.include?(:global)
          types << 'global-setid' if disabled_cores.include?(:global_setid)
          types << 'process' if disabled_cores.include?(:per_process)
          types << 'proc-setid' if disabled_cores.include?(:per_process_setid)
        end
      end

      private

      def validate_type(type)
        return if TYPES.include?(type)
        fail Exceptions::ValidationFailed, 'Option #enable must be equal ' \
          "to one of: #{TYPES.join(', ')}!  You passed #{type.inspect}."
      end
    end
  end
end
