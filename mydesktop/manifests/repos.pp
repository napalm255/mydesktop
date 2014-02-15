class mydesktop::repos {
  # setup 'system' git directory
  file { '/opt/git' :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  #
  # tmux
  #
  # git tmux.conf
  vcsrepo { '/opt/git/tmux' :
    ensure   => present,
    provider => git,
    source   => 'https://gist.github.com/8810252.git',
    user     => 'root',
    require  => File['/opt/git'],
  }
  # link tmux.conf
  file { '/etc/tmux.conf' :
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/git/tmux/tmux.conf',
    require => Vcsrepo['/opt/git/tmux'],
  }

  #
  # zdesktop aka bashrc
  #
  # git zdesktop.sh
  vcsrepo { '/opt/git/profile' :
    ensure   => present,
    provider => git,
    source   => 'https://gist.github.com/8995797.git',
    user     => 'root',
    require  => File['/opt/git'],
  }
  # link profile.d/zdesktop.sh
  file { '/etc/profile.d/zdesktop.sh' :
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/git/profile/zdesktop.sh',
    require => Vcsrepo['/opt/git/profile'],
  }

  #
  # wemux
  #
  # git webmux
  vcsrepo { '/opt/git/wemux' :
    ensure   => present,
    provider => git,
    source   => 'https://github.com/zolrath/wemux.git',
    user     => 'root',
    require  => File['/opt/git'],
  }
  # link /usr/local/share/wemux
  file { '/usr/local/share/wemux' :
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/git/wemux',
    require => Vcsrepo['/opt/git/wemux'],
  }
  # link /usr/local/bin/wemux
  file { '/usr/local/bin/wemux' :
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/usr/local/share/wemux/wemux',
    require => File['/usr/local/share/wemux'],
  }
  # setup wemux.conf
  file { '/usr/local/etc/wemux.conf' :
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('mydesktop/wemux.conf.erb'),
    #source => 'puppet:///modules/mydesktop/wemux.conf',
    require => Vcsrepo['/opt/git/wemux'],
  }
  # setup tmp directory
  file { '/tmp/wemux/' :
    ensure => directory,
    owner  => $user,
    group  => $user,
    mode   => '1777',
  }
}
