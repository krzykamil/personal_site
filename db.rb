begin
  require_relative '.env.rb'
rescue LoadError
end

require 'sequel/core'

# Delete _DATABASE_URL from the environment, so it isn't accidently
# passed to subprocesses.  _DATABASE_URL may contain passwords.
DB = Sequel.connect(ENV.delete('PERSONAL_SITE_DATABASE_URL') || ENV.delete('DATABASE_URL'))
