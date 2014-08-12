actions :create, :remove
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :type, :kind_of => String, :default => "master"
attribute :ttl, :kind_of => String, :default => "604800"
attribute :refresh, :kind_of => String, :default => "604800"
attribute :retry, :kind_of => String, :default => "86400"
attribute :expire, :kind_of => String, :default => "2419200"
attribute :negative_cache_ttl, :kind_of => String, :default => "604800"
attribute :records, :kind_of => Array, :default => []
