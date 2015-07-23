coreadm Cookbook
================

Sets coreadm defaults.

* Platform: SmartOS

## Usage

```ruby
include_recipe 'coreadm'

coreadm 'do stuff' do
  global_pattern '/var/cores/global.core.%p'
  per_process_pattern '/var/cores/init.core.%p'
  disable :global
  enable :per_process, :global_setid, :per_process_setid
end
```
