class puppet {
  include puppet::params, puppet::install, puppet:config, puppet::service
}
