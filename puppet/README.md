Make sure the puppet server has at least 2G of RAM.
Make sure the TCP por tof 8140 is reachable through security group. 

Installation on Puppet Master:
sudo su
apt-get update
wget http://apt.puppet.com/pool/bionic/puppet-release/p/puppet-release/puppet-release_1.0.0-14bionic_all.deb
dpkg -i puppet-release_1.0.0-14bionic_all.deb
apt-get update
apt-get install puppetserver -y
systemctl start puppetserver
systemctl status puppetserver
bash -l
puppetserver -v
Now specify the puppet IP in /etc/hosts by adding the following line to the file: x.x.x.x[public ipv4] puppet
/opt/puppetlabs/puppet/bin/gem install -i /opt/puppetlabs/puppet/lib/ruby/vendor_gems puppetserver-ca
puppetserver ca sign --certname ip-10-0-2-180.ap-southeast-2.compute.internal[slave ipv4 private domain name]
puppetserver ca sign --certname ip-10-0-2-22.ap-southeast-2.compute.internal
Add a simulink: ln -s /opt/puppetlabs/bin/puppetserver /usr/local/sbin/puppetserver


Installation on Puppet Master:
sudo su
apt-get update
wget http://apt.puppet.com/pool/bionic/puppet-release/p/puppet-release/puppet-release_1.0.0-14bionic_all.deb
dpkg -i puppet-release_1.0.0-14bionic_all.deb
apt-get update
apt-get install puppet-agent
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
source /etc/profile.d/puppet-agent.sh
Now specify the puppet IP in /etc/hosts by adding the following line to the file: x.x.x.x[public ipv4] puppet
puppet config set server ip-10-0-1-93.ap-southeast-2.compute.internal[please use the puppet master internal private ipv4 domain name rather than the public] --section main
puppet ssl bootstrap
puppet agent --test
make sure the following server block exists in file of: cat /etc/puppetlabs/puppet/puppet.conf
'''[main]
server = ip-10-0-1-93.ap-southeast-2.compute.internal'''
Export puppet into the PATH variable for current terminal: export PATH=/opt/puppetlabs/bin/:$PATH
If you want to change the path permanently, edit the /etc/environment file and insert "/opt/puppetlabs/bin" into the PATH.



Issues:
1. If you shutdown the master/salve EC2 instances during overnight, the public IPv4 address will be different when they are
powered on again the next day, so it is needed to update the /etc/hosts of the ipv4 master new ipv4 address on both server/node,
then restart puppetserver status with the following commands:
vim /etc/hosts
puppetserver ca list --all
service puppetserver restart

