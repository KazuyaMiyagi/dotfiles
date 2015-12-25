if [ ! $(id -u) -eq 0 ] ; then
    echo "Not root"
    exit 1
fi

if [ -f /etc/redhat-release ] ; then
yum -y install git curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel
pushd /usr/local/src
if [ ! -d git ] ; then
    git clone git://git.kernel.org/pub/scm/git/git.git
fi
cd git
git pull
make configure
./configure --prefix=/usr/local
make all
make install
make clean
popd
fi
