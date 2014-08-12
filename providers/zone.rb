action :create do

    attributes = {
        "name" => new_resource.name,
        "type" => new_resource.type,
        "ttl" => new_resource.ttl,
        "serial" => Time.now.to_i,
        "refresh" => new_resource.refresh,
        "retry" => new_resource.retry,
        "expire" => new_resource.expire,
        "negative_cache_ttl" => new_resource.negative_cache_ttl,
        "records" => new_resource.records
    }

    # update node attributes
    node.automatic['bind9']['zones'][new_resource.name] = attributes

    # write zone file
    template "#{node['bind9']['base_dir']}/#{new_resource.name}" do
        cookbook "bind9"
        source "zone.erb"
        owner "root"
        group "root"
        mode 0644
        variables({
            :zone => attributes,
            :dns_servers => search(:node, node['bind9']['search'])
        })
        notifies :run, "execute[reload rndc]", :delayed
    end

    # write named.conf.local file
    template "#{node['bind9']['base_dir']}/named.conf.local" do
        cookbook "bind9"
        source "named.conf.local.erb"
        owner "root"
        group "root"
        mode 0644
    end

    # reload rndc
    execute "reload rndc" do
        command "rndc reload"
        action :nothing
    end

    # resource was updated
    new_resource.updated_by_last_action(true)

end

action :remove do

    # update node attributes
    node.automatic['bind9']['zones'].delete(new_resource.name)

    # remove zone file
    file "#{node['bind9']['base_dir']}/#{new_resource.name}" do
        action :remove
    end

    # write named.conf.local file
    template "#{node['bind9']['base_dir']}/named.conf.local" do
        cookbook "bind9"
        source "named.conf.local.erb"
        owner "root"
        group "root"
        mode 0644
    end

    # reload rndc
    execute "reload rndc" do
        command "rndc reload"
        action :nothing
    end

    # resource was updated
    new_resource.updated_by_last_action(true)

end
