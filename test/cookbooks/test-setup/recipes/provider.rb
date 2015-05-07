include_recipe 'coreadm'

coreadm 'configure coreadm' do
  global_pattern '/var/core/global.core.%p'
  per_process_pattern '/var/core/init.core.%p'
  disable :global
  enable :per_process, :global_setid, :per_process_setid
end
