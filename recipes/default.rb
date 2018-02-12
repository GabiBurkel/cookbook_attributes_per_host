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
