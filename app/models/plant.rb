class Plant < ActiveRecord::Base
  attr_accessible :common_name, :plant_family, :plant_symbol, :sci_name, :syn_symbol
end
