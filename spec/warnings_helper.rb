# frozen_string_literal: true

begin
  require 'warning'
rescue LoadError
else
  $VERBOSE = true
  Warning.ignore(%i[missing_ivar method_redefined], File.dirname(__dir__))
  Gem.path.each do |path|
    Warning.ignore(%i[missing_ivar method_redefined not_reached], path)
  end
end
