if [ -f /etc/redhat-release ] ; then
  sudo yum -y install git curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel
  pushd /usr/src
  if [ ! -d git ] ; then
    sudo git clone git://git.kernel.org/pub/scm/git/git.git
  fi
  cd git
  make configure
  ./configure --prefix=/usr
  make all doc info
  sudo make install install-doc install-html install-info
  popd
fi
