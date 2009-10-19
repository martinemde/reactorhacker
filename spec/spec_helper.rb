require 'spec'
require 'spec/autorun'

$LOAD_PATH.unshift(File.dirname(__FILE__))

require File.join(File.dirname(__FILE__), *%w[.. lib reactorhacker])

Spec::Runner.configure do |config|

end
