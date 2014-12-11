class mydesktop::tools {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  # setup 'system' git directory
  file { '/opt/git' :
    ensure  => directory,
  }

  # tmux
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
    target  => '/opt/git/tmux/mydesktop.tmux.conf',
    require => Vcsrepo['/opt/git/tmux'],
  }

  # zdesktop aka bashrc
  vcsrepo { '/opt/git/profile' :
    ensure   => present,
    provider => git,
    source   => 'https://gist.github.com/8995797.git',
    user     => 'root',
    require  => File['/opt/git'],
  }
  # link profile.d/mydesktop.profile.sh
  file { '/etc/profile.d/mydesktop.profile.sh' :
    ensure  => link,
    target  => '/opt/git/profile/mydesktop.profile.sh',
    require => Vcsrepo['/opt/git/profile'],
  }

  # powerbash
  vcsrepo { '/opt/git/powerbash' :
    ensure   => present,
    provider => git,
    source   => 'https://github.com/napalm255/powerbash.git',
    user     => 'root',
    require  => File['/opt/git'],
  }
  # link profile.d/zpowerbash.sh 
  file { '/etc/profile.d/zpowerbash.sh' :
    ensure  => link,
    target  => '/opt/git/powerbash/powerbash.sh',
    require => Vcsrepo['/opt/git/powerbash'],
  }

}
