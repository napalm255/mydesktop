class mydesktop::system () {

  $tools_cli = [ 'tmux', 'vim-enhanced', 'git', 'puppet', 'htop', 'nmap', 'lynx', 'curl', 'wget', 'whois', 'ipcalculator', 'figlet', 'telnet', 'traceroute', 'autofs' ]
  $tools_net = [ 'samba-client', 'samba-common', 'putty', 'iperf3' ]
  $tools_cmp = [ 'p7zip', 'p7zip-plugins', 'unzip', 'bzip2' ]
  $tools_gui = [ 'xpad', 'gnome-tweak-tool', 'gimp', 'geany', 'bluefish' ]
  $tools_ssh = [ 'openssh', 'openssh-server', 'openssh-clients' ]
  $tools_dev = [ 'python-pip', 'kernel-headers', 'kernel-devel', 'gcc', 'binutils', 'make', 'libgomp', 'glibc-headers', 'glibc-devel', 'dkms',
                 'gcc-c++', 'patch', 'readline', 'readline-devel', 'zlib', 'zlib-devel', 'libyaml-devel', 'libffi-devel', 'openssl-devel', 'cmake',
                 'autoconf', 'automake', 'libtool', 'bison' ]
  $tools_av  = [ 'clamav', 'clamav-update' ]

  package { [ $tools_cli, $tools_net, $tools_cmp, $tools_gui, $tools_ssh, $tools_dev, $tools_av ] :
    ensure => latest,
  }

  # chrome
  package { 'google-chrome-stable' :
    ensure  => latest,
    require => Yumrepo['google-chrome'],
  }

  # ssh - enable and start
  service { 'sshd' :
    ensure  => running,
    enable  => true,
    require => Package['openssh-server'],
  }

  # yum repos
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

}
