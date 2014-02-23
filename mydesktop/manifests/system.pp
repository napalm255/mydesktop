class mydesktop::system () {

  $tools_cli = [ 'git', 'puppet', 'htop', 'nmap', 'lynx', 'wget', 'whois', 'ipcalculator', 'figlet', 'telnet', 'traceroute', 'samba-client', 'samba-common', 'autofs', 'putty', 'tmux', 'vim-enhanced', 'python-pip', 'iperf3', 'p7zip', 'p7zip-plugins', 'unrar' ]
  $tools_gui = [ 'xpad', 'gnome-tweak-tool', 'gimp', 'geany', 'bluefish' ]
  $tools_ssh = [ 'openssh', 'openssh-server', 'openssh-clients' ]
  $tools_dev = [ 'kernel-headers', 'kernel-devel', 'gcc', 'binutils', 'make', 'patch', 'libgomp', 'glibc-headers', 'glibc-devel', 'dkms' ]
  $tools_av  = [ 'clamav', 'clamav-update' ]

  package { $tools_cli :
    ensure => latest,
  }

  package { $tools_gui :
    ensure => latest,
  }

  package { $tools_ssh :
    ensure => latest,
  }

  package { $tools_dev :
    ensure => latest,
  }

  # anti-virus
  package { $tools_av :
    ensure => latest,
  }


  service { 'sshd' :
    ensure  => running,
    enable  => true,
    require => Package['openssh-server'],
  }

  yumrepo { "google_$architecture" :
    name     => "google_$architecture",
    descr    => "Google - $architecture",
    baseurl  => "http://dl.google.com/linux/rpm/stable/$architecture",
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'https://dl-ssl.google.com/linux/linux_signing_key.pub',
  }

  yumrepo { 'google-chrome' :
    name     => 'google-chrome',
    descr    => 'google-chrome',
    baseurl  => "http://dl.google.com/linux/chrome/rpm/stable/$architecture",
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'https://dl-ssl.google.com/linux/linux_signing_key.pub',
  }

  package { 'google-chrome-stable' :
    ensure  => latest,
    require => Yumrepo['google-chrome'],
  }

  yumrepo { 'virtualbox' :
    name     => 'virtualbox',
    descr    => 'Fedora $releasever - $basearch - VirtualBox',
    enabled  => 1,
    baseurl  => 'http://download.virtualbox.org/virtualbox/rpm/fedora/$releasever/$basearch',
    gpgcheck => 1,
    gpgkey   => 'http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc',
  }

  package { 'virtualbox':
    name    => 'VirtualBox-4.3',
    ensure  => latest,
    require => Yumrepo['virtualbox'],
  }

  exec { 'vboxdrv':
    command => '/etc/init.d/vboxdrv setup',
    user    => 'root',
    unless  => '/etc/init.d/vboxdrv status',
  }

  service { 'vboxdrv' :
    ensure    => running,
    enable    => true,
    require   => [ Exec['vboxdrv'], ],
  }

  cron { 'freshclam' :
    ensure  => present,
    command => '/usr/bin/freshclam',
    user    => 'root',
    hour    => 22,
    minute  => 0,
  }

  cron { 'yum-update' :
    ensure  => present,
    command => 'yum -y update',
    user    => 'root',
    hour    => 8,
    minute  => 0,
  }
}
