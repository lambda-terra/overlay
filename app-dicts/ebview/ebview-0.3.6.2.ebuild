# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils autotools

IUSE=""

DESCRIPTION="EBView -- Electronic Book Viewer based on GTK+"
HOMEPAGE="http://ebview.sourceforge.net/"
#SRC_URI="http://ftp.de.debian.org/debian/pool/main/e/ebview/${P}.orig.tar.gz"
SRC_URI="http://ftp.de.debian.org/debian/pool/main/e/ebview/ebview_0.3.6.2.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

RDEPEND=">=dev-libs/eb-3.3.4
	>=x11-libs/gtk+-2.2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconf"

src_prepare() {
	epatch "${FILESDIR}"/${P}-destdir.patch
	epatch "${FILESDIR}"/${P}-use-pangoxft.patch
	epatch "${FILESDIR}"/${P}-ldfix.patch
	eautoreconf
}

src_configure () {
	econf --with-eb-conf=/etc/eb.conf || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	
	mkdir -p "${D}"/usr/share/applications
	mkdir -p "${D}"/usr/share/pixmaps
	cp "${FILESDIR}"/ebview.desktop "${D}"/usr/share/applications/
	cp "${S}"/pixmaps/ebview-32x32.xpm "${D}"/usr/share/pixmaps/ebview.xpm

	dodoc AUTHORS ChangeLog INSTALL* NEWS README
}
