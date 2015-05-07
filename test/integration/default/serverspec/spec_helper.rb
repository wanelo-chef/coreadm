require 'serverspec'
require 'pathname'
require 'net/http'
require 'net/smtp'
require 'json'

Gem.use_paths(nil, Gem.path << '/opt/chef/embedded/lib/ruby/gems/1.9.1')
$LOAD_PATH.unshift '/tmp/kitchen/cookbooks/coreadm'

set :backend, :exec

# Allow chef node attributes to be
# accessed inside of RSpec examples.
module NodeHelpers
  def node
    @node ||= ::JSON.parse(File.read('/tmp/kitchen/cache/node.json'))
  end
end

RSpec.configure do |c|
  c.include NodeHelpers
end
