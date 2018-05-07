puts('*******************************************')
puts('********** Hostname: ' + node['hostname'])
puts('*******************************************')

template '/tmp/mysql-config' do
  source 'mysql-config-template'
  mode '0644'
  owner 'root'
  group 'root'
  variables(config001: node['default001'],
            config002: node['default002'],
            config003: node['default003'],
            config004: node['default004'])
end

unless Chef::Config['file_cache_path'].include?('kitchen')
  puts('We are not running in testkitchen')
end
