describe file('/tmp/mysql-config') do
  its('type') { should eq :file }
  its('content') { should include('common-001') }
  its('content') { should include('common-002') }
  its('content') { should include('common-003-d-ber1-testkitchen-003') }
  its('content') { should include('common-004-d-ber1-testkitchen-003') }
end
