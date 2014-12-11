class mydesktop::vim {

  File {
    owner => $mydesktop::user,
    group => $mydesktop::user,
    mode  => '0664',
  }

  file { '.vim/autoload' :
    ensure  => directory,
    path    => "/home/${mydesktop::user}/.vim/autoload",
  }

  file { "/home/${mydesktop::user}/.vim/autoload/pathogen.vim" :
    ensure  => present,
    source  => 'puppet:///modules/mydesktop/pathogen.vim',
    require => File['.vim/autoload'],
  }

  vcsrepo { "/home/${mydesktop::user}/.vim/bundle/syntastic" :
    ensure   => present,
    provider => git,
    source   => 'https://github.com/scrooloose/syntastic.git',
    user     => $mydesktop::user,
  }

  vcsrepo { "/home/${mydesktop::user}/.vim/bundle/tabular" :
    ensure   => present,
    provider => git,
    source   => 'https://github.com/godlygeek/tabular.git',
    user     => $mydesktop::user,
  }

  vcsrepo { "/home/${mydesktop::user}/.vim/bundle/tlib_vim" :
    ensure   => present,
    provider => git,
    source   => 'https://github.com/tomtom/tlib_vim.git',
    user     => $mydesktop::user,
  }

  vcsrepo { "/home/${mydesktop::user}/.vim/bundle/vim-addon-mw-utils" :
    ensure   => present,
    provider => git,
    source   => 'https://github.com/MarcWeber/vim-addon-mw-utils.git',
    user     => $mydesktop::user,
  }

  vcsrepo { "/home/${mydesktop::user}/.vim/bundle/vim-puppet" :
    ensure   => present,
    provider => git,
    source   => 'https://github.com/rodjek/vim-puppet.git',
    user     => $mydesktop::user,
  }

  vcsrepo { "/home/${mydesktop::user}/.vim/bundle/vim-snipmate" :
    ensure   => present,
    provider => git,
    source   => 'https://github.com/garbas/vim-snipmate.git',
    user     => $mydesktop::user,
  }

  vcsrepo { "/home/${mydesktop::user}/.vim/bundle/vim-snippets" :
    ensure   => present,
    provider => git,
    source   => 'https://github.com/honza/vim-snippets.git',
    user     => $mydesktop::user,
  }

  vcsrepo { "/home/${mydesktop::user}/.vim/bundle/vim-airline" :
    ensure   => present,
    provider => git,
    source   => 'https://github.com/bling/vim-airline.git',
    user     => $mydesktop::user,
  }

  vcsrepo { "/home/${mydesktop::user}/.vim/bundle/nerdtree" :
    ensure   => present,
    provider => git,
    source   => 'https://github.com/scrooloose/nerdtree.git',
    user     => $mydesktop::user,
  }

}
