PORTNAME=	azahar
PORTVERSION=	2123.2
CATEGORIES=	emulators

MAINTAINER=	kreinholz@gmail.com
COMMENT=	Nintendo 3DS emulator/debugger
WWW=		https://azahar-emu.org

LICENSE=	BSD2CLAUSE BSD3CLAUSE BSL GPLv2+ ISCL LGPL21+ MIT OpenSSL UNLICENSE
LICENSE_COMB=	multi
LICENSE_FILE_BSD2CLAUSE=${WRKSRC}/externals/fmt/LICENSE
LICENSE_FILE_BSD3CLAUSE=${WRKSRC}/externals/inih/inih/LICENSE.txt
LICENSE_FILE_BSL=	${WRKSRC}/externals/catch2/LICENSE.txt
LICENSE_FILE_GPLv2+ =	${WRKSRC}/license.txt
LICENSE_FILE_ISCL=	${WRKSRC}/externals/cubeb/LICENSE
LICENSE_FILE_LGPL21+ =	${_LICENSE_STORE}/LGPL21 # soundtouch
LICENSE_FILE_MIT=	${WRKSRC}/externals/enet/LICENSE
LICENSE_FILE_OpenSSL=	${WRKSRC}/externals/libressl/COPYING

BUILD_DEPENDS=	boost-libs>0:devel/boost-libs

USE_GITHUB=	yes
GH_ACCOUNT=	azahar-emu
GH_TAGNAME=	2123.2
GH_TUPLE=	azahar-emu:ext-boost:3c27c785ad0f8a742af02e620dc225673f3a12d8:extboost/externals/boost \
		neobrain:nihstro:f4d8659decbfe5d234f04134b5002b82dc515a44:nihstro/externals/nihstro \
        	azahar-emu:soundtouch:2.3.3-9-g9ef8458:soundtouch/externals/soundtouch \
        	catchorg:Catch2:v3.8.0:Catch2/externals/catch2 \
		facebook:zstd:v1.4.8:zstd/externals/zstd \
        	azahar-emu:dynarmic:278405bd71999ed3f3c77c5f78344a06fef798b9:dynarmic/externals/dynarmic \
        	herumi:xbyak:v3.71-1460-g0d67fd1:xbyak/externals/xbyak \
        	fmtlib:fmt:123913715afeb8a437e6388b4473fcc4753e1c9a:fmt/externals/fmt \
        	lsalzman:enet:v1.3.15-47-g2662c0d:enet/externals/enet \
        	benhoyt:inih:5cc5e2c24642513aaa5b19126aad42d0e4e0923e:inih/externals/inih/inih \
        	azahar-emu:ext-libressl-portable:88b8e41b71099fabc57813bc06d8bc1aba050a19:extlibresslportable/externals/libressl \
        	mozilla:cubeb:832fcf38e600bf80b4b728a3e0227403088d992c:cubeb/externals/cubeb \
        	arun11299:cpp-jwt:4a970bc302d671476122cbc6b43cc89fbf4a96ec:cppjwt/externals/cpp-jwt \
        	wwylele:teakra:01db7cdd00aabcce559a8dddce8798dabb71949b:teakra/externals/teakra \
		lvandeve:lodepng:0b1d9ccfc2093e5d6620cd9a11d03ee6ff6705f5:lodepng/externals/lodepng/lodepng \
        	lemenkov:libyuv:6f729fbe658a40dfd993fa8b22bd612bb17cde5c:libyuv/externals/libyuv \
        	weidai11:cryptopp:CRYPTOPP_8_9_0-19-g60f81a77:cryptopp/externals/cryptopp \
		abdes:cryptopp-cmake:CRYPTOPP_8_9_0-20-g00a151f:cryptoppcmake/externals/cryptopp-cmake \
        	septag:dds-ktx:c3ca8febc2457ab5c581604f3236a8a511fc2e45:ddsktx/externals/dds-ktx \
        	KhronosGroup:glslang:11.1.0-1230-gfc9889c8:glslang/externals/glslang \
        	GPUOpen-LibrariesAndSDKs:VulkanMemoryAllocator:v2.1.0-933-gc788c52:VulkanMemoryAllocator/externals/vma \
        	KhronosGroup:Vulkan-Headers:v1.4.313:VulkanHeaders/externals/vulkan-headers \
		azahar-emu:sirit:37d49d2aa4c0a62f872720d6e5f2eaf90b2c95fa:sirit/externals/sirit/sirit \
        	knik0:faad2:216f00e8ddba6f2c64caf481a04f1ddd78b93e78:faad2/externals/faad2/faad2 \
        	azahar-emu:ext-library-headers:3b3e28dbe6d033395ce2967fa8030825e7b89de7:extlibraryheaders/externals/library-headers \
        	merryhime:oaknut:6b1d57ea7ed4882d32a91eeaa6557b0ecb4da152:oaknut/externals/oaknut \
        	azahar-emu:compatibility-list:a36decbe43d0e5a570ac3d3ba9a0b226dc832a17:compatibilitylist/dist/compatibility_list \
        	KhronosGroup:SPIRV-Tools:v2022.4-759-ga62abcb4:SPIRVTools/externals/spirv-tools \
        	KhronosGroup:SPIRV-Headers:1.5.4.raytracing.fixed-411-gaa6cef1:SPIRVHeaders/externals/spirv-headers \
        	arsenm:sanitizers-cmake:aab6948fa863bc1cbe5d0850bc46b9ef02ed4c1a:sanitizerscmake/externals/cubeb/cmake/sanitizers-cmake \
		azahar-emu:mcl:7b08d83418f628b800dfac1c9a16c3f59036fbad:mcl/externals/dynarmic/externals/mcl \
		Tessil:robin-map:054ec5ad67440fcd65e0497e5a27ef31f53fcc7f:robinmap/externals/dynarmic/externals/robin-map \
		zyantific:zydis:bffbb610cfea643b98e87658b9058382f7522807:zydis/externals/dynarmic/externals/zydis \
		zyantific:zycore-c:0b2432ced0884fd152b471d97ecf0258ff4d859f:zycorec/externals/dynarmic/externals/zycore

USES=		cmake:testing compiler:c++17-lang localbase:ldflags sdl
USE_SDL=	sdl2
CMAKE_ON=	USE_SYSTEM_BOOST Boost_USE_STATIC_LIBS
LDFLAGS+=	-Wl,--as-needed # Qt5Network

OPTIONS_DEFINE=	ALSA FFMPEG JACK PULSEAUDIO QT6 SDL SNDIO
OPTIONS_DEFAULT=FFMPEG JACK PULSEAUDIO QT6 SDL SNDIO

CMAKE_ARGS+=		-DENABLE_OPENAL:BOOL=OFF \
			-DENABLE_LIBUSB:BOOL=OFF \
			-DUSE_SYSTEM_SDL2:BOOL=ON 

ALSA_BUILD_DEPENDS=	alsa-lib>0:audio/alsa-lib
ALSA_CMAKE_BOOL=	USE_ALSA

FFMPEG_LIB_DEPENDS=	libavcodec.so:multimedia/ffmpeg
FFMPEG_CMAKE_BOOL=	ENABLE_FFMPEG_AUDIO_DECODER ENABLE_FFMPEG_VIDEO_DUMPER

JACK_BUILD_DEPENDS=	jackit>0:audio/jack
JACK_CMAKE_BOOL=	USE_JACK

PULSEAUDIO_BUILD_DEPENDS=pulseaudio>0:audio/pulseaudio
PULSEAUDIO_CMAKE_BOOL=	USE_PULSE

SNDIO_BUILD_DEPENDS=	sndio>0:audio/sndio
SNDIO_CMAKE_BOOL=	USE_SNDIO

SDL_CMAKE_BOOL=	ENABLE_SDL2

QT6_USES=	desktop-file-utils qt:6 shared-mime-info
USE_QT+=	base multimedia
QT6_CMAKE_BOOL=	ENABLE_QT ENABLE_QT_TRANSLATION

.include <bsd.port.pre.mk>

post-patch:
	@${REINPLACE_CMD} -e 's/@GIT_BRANCH@/master/' \
		-e 's/@GIT_DESC@/${GH_TAGNAME}/' \
		${WRKSRC}/src/common/scm_rev.cpp.in
.if ${COMPILER_TYPE} == clang
	@${REINPLACE_CMD} -e 's|std::unary_function|std::__unary_function|' \
		${WRKSRC}/externals/boost/boost/container_hash/hash.hpp
.endif

.include <bsd.port.post.mk>
