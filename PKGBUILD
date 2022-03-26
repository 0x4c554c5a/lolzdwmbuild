# Maintainer: Aditya Shakya <adi1090x@gmail.com>

pkgname=lolzdwmbuild
pkgver=1.0
pkgrel=3
pkgdesc="DWM for Archcraft"
url="https://github.com/0x4c554c5a/lolzdwmbuild"
arch=('any')
options=(zipman)
depends=('libx11' 'libxinerama' 'libxft' 'freetype2' 'archcraft-st' 'hsetroot')
conflicts=('dwm')
provides=("${pkgname}")
options=(!strip !emptydirs)

prepare() {
	cp -af ../source/. ${srcdir}
	cp -af ../shared ${srcdir}
}

build() {
  cd "$srcdir"
  make X11INC=/usr/include/X11 X11LIB=/usr/lib/X11 FREETYPEINC=/usr/include/freetype2
}

package() {
  cd "$srcdir"
  make PREFIX=/usr DESTDIR="$pkgdir" install
  install -m644 -D "$srcdir/dwm.desktop" "$pkgdir/usr/share/xsessions/dwm.desktop"

  ## Install shared files
  local _dwmdir=${pkgdir}/usr/share/archcraft
  mkdir -p "$_dwmdir"

  cp -r ${srcdir}/shared 		"$_dwmdir"/dwm
  chmod +x "$_dwmdir"/dwm/bin/*
  chmod +x "$_dwmdir"/dwm/rofi/bin/*
}
