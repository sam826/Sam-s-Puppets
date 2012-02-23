class base {
  include ssh, puppet
}

node 'vm-pc-ub-1.nyc.rr.com'{
	include base
	include puppet::master
}

node 'vm-pc-ub-2.nyc.rr.com'{
	include base
}

node 'vm-pc-ub-3.nyc.rr.com'{
	include base
}

