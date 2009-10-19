$LOAD_PATH.unshift(File.dirname(__FILE__))

module ReactorHacker
  autoload :App,     'reactorhacker/app'
  autoload :Pick,    'reactorhacker/pick'
  autoload :Term,    'reactorhacker/term'
  autoload :WordSet, 'reactorhacker/word_set'
  autoload :Word,    'reactorhacker/word'
end
