set -e -x

source /etc/lsb-release

function apt_get() {
  apt-get -y --force-yes --no-install-recommends "$@"
}

packages="
aptitude
argon-dev
autoconf
bison
build-essential
bzr
ca-certificates
cmake
curl
dconf-gsettings-backend
dnsutils
fakeroot
flex
fuse-emulator-utils
gdb
git-core
gnupg-curl
gsfonts
imagemagick
iputils-arping
jq
krb5-user
laptop-detect
libaio1
libatm1
libavcodec54
libboost-iostreams1.54.0:amd64
libcurl4-openssl-dev
libcwidget3
libdirectfb-1.2-9
libdrm-intel1
libdrm-nouveau2
libdrm-radeon1
libept1.4.12:amd64
libfuse-dev
libgd2-noxpm-dev
libgmp-dev
libgpm2
libgtk-3-0
libicu-dev
liblapack-dev
libmagickwand-dev
libmariadbclient-dev
libncurses5-dev
libopenblas-dev
libpango1.0-0
libparse-debianchangelog-perl
libpq-dev
libreadline6-dev
libsasl2-dev
libsasl2-modules
libselinux1-dev
libsigc++-2.0-0c2a:amd64
libsqlite0-dev
libsqlite3-dev
libsysfs2
libxapian22
libxcb-render-util0
libxslt1-dev
libyaml-dev
lsof
lzma
manpages-dev
mercurial
ocaml-base-nox
openssh-server
psmisc
quota
rsync
ruby
sshfs
strace
subversion
sysstat
tasksel
tasksel-data
tcpdump
traceroute
ttf-dejavu-core
unzip
uuid-dev
wget
zip
"
if [ "`uname -m`" == "ppc64le" ]; then
  packages=$(sed '/\b\(libopenblas-dev\|libdrm-intel1\|dmidecode\)\b/d' <<< "${packages}")
  ubuntu_url="http://ports.ubuntu.com/ubuntu-ports"
else
  ubuntu_url="http://archive.ubuntu.com/ubuntu"
fi

cat > /etc/apt/sources.list <<EOS
deb $ubuntu_url $DISTRIB_CODENAME main universe multiverse
deb $ubuntu_url $DISTRIB_CODENAME-updates main universe multiverse
deb $ubuntu_url $DISTRIB_CODENAME-security main universe multiverse
EOS

apt_get update
apt_get dist-upgrade
apt_get install $packages ubuntu-minimal

apt-get clean

rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/groff/* /usr/share/info/* /usr/share/lintian/* /usr/share/linda/*

