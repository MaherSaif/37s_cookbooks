include_recipe "base"

node[:users].each do |name, config| 
    
  keys = {}
  keys[name] = node[:ssh_keys][name]
  
  config[:ssh_keys].each do |user|
    keys[user] = node[:ssh_keys][user]
  end
    
  template "/home/#{name}/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    action :create
    owner config[:username]
    group config[:gid]
    variables(:key => keys)
    mode 0600
  end

end