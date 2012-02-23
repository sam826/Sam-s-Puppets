class base {
  include ssh
}

node 'vm-pc-ub-1.nyc.rr.com'{
	include base
}

node 'vm-pc-ub-2.nyc.rr.com'{
	include base
}

node 'vm-pc-ub-3.nyc.rr.com'{
	include base
}

