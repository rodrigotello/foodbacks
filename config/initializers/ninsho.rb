# This hook is use to setup the configuration for creating models through
# rails generators
Ninsho.setup do |config|
  
  # ==> ORM Configuration
  # Load and configure the ORM. Supports :active_record
  require 'ninsho/orm/active_record'


  #Omniauth Providers
   if Rails.env == "development" || Rails.env == "test"
		config.omniauth :facebook, "533508706720467", "967306f58f12b8270e417a2c8918772c", :scope => 'email'
    else
    	config.omniauth :facebook, "297437987064065", "15f03b79a6e9dfa42988b2a64cedfd59", :scope => 'email'  
   end
end
