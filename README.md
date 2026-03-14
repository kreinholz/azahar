# FreeBSD port of Azahar - Nintendo 3DS emulator

This is an unofficial FreeBSD port of Azahar, the successor project to Citra (https://azahar-emu.org/).

With the emulators/citra and emulators/citra-qt5 ports set to be removed from the FreeBSD Ports collection on 31 October 2025, I thought it prudent to prepare a new port of Azahar, where development of the Citra codebase has continued following that project's demise.

To build on FreeBSD:

Clone this repository:

git clone git@github.com:kreinholz/azahar.git

cd azahar

sudo make install clean

(Alternatively, run 'make install clean' as root)

As of azahar v2125.0-rc1, it's also possible to build a libretro core for azahar. To do so, create a directory labeled 'liberetro-azahar' and place it in the same containing folder as the 'azahar' port. The libretro-azahar slave port only requires one file: Makefile. Its contents can be copied from the /usr/ports/emulators/libretro-ppsspp slave port, the only required change being to the MASTERDIR line as follows:

MASTERDIR=	${.CURDIR}/../azahar

emulators/azahar and emulators/libretro-azahar can peacefully coexist, as the only file installed by libretro-azahar is ${LOCALBASE}/lib/libretro/azahar_libretro.so
