# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit rpm

DESCRIPTION="Japanese-Russian kanji dictionary"
HOMEPAGE="http://www.susi.ru/yarxi/mac_linux.html"

SUSI_URI="http://www.susi.ru/yarxi/yarxi-${PV}-1"
SRC_URI="${SRC_URI}
	amd64? ( ${SUSI_URI}.x86_64.rpm -> ${P}.x86_64.rpm )
	x86? ( ${SUSI_URI}.i386.rpm -> ${P}.i386.rpm )"


LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	rpm_src_unpack ${A}
	mkdir ${S}
	mv usr ${S}
}

src_install() {
	# remove CR
	sed -i 's/\r$//' usr/share/applications/seva-yarxi.desktop
	# add missing semicolon
	sed -i 's/Education/Education;/' usr/share/applications/seva-yarxi.desktop
	mv usr ${D}
}
