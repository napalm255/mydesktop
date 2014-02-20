class mydesktop::system () {

  $tools_cli = [ 'git', 'puppet', 'htop', 'nmap', 'lynx', 'wget', 'whois', 'ipcalculator', 'figlet', 'telnet', 'traceroute', 'samba-client', 'samba-common', 'autofs', 'putty', 'tmux', 'vim-enhanced' ]
  $tools_gui = [ 'xpad', 'gnome-tweak-tool', 'gimp' ]
  $tools_ssh = [ 'openssh', 'openssh-server', 'openssh-clients' ]

  package { $tools_cli :
    ensure => latest,
  }

  package { $tools_gui :
    ensure => latest,
  }

  package { $tools_ssh :
    ensure => latest,
  }

  service { 'sshd' :
    ensure  => running,
    enable  => true,
    require => Package['openssh-server'],
  }

  file { "/etc/yum.repos.d/google_$architecture.repo" :
    ensure => present,
    source => "puppet:///modules/mydesktop/google_$architecture.repo",
    owner  => 'root',
    group  => 'root',
  }

  package { 'google-chrome-stable' :
    ensure => latest,
    require => File["/etc/yum.repos.d/google_$architecture.repo"],
  }

  cron { 'yum-update' :
    command => 'yum -y update',
    user    => 'root',
    hour    => 8,
    minute  => 0,
    weekday => [2, 4],
  }
}
