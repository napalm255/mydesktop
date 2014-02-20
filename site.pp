node gibsonb-desk {
  class { 'mydesktop' :
    user => 'bgibson',
  }
}

node x55c-localdomain {
  class { 'mydesktop' :
    user => 'napalm',
  }
}
