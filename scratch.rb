begin
  "String".hey_there # our existing code
rescue StandardError => e
  require "pry"; binding.pry
end

