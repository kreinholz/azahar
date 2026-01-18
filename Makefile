PORTNAME=	azahar
DISTVERSION=	2124
CATEGORIES=	emulators

MAINTAINER=	kreinholz@gmail.com
COMMENT=	Nintendo 3DS emulator/debugger
WWW=		https://azahar-emu.org

LICENSE=	GPLv2+ ISCL
LICENSE_COMB=	multi
LICENSE_FILE_GPLv2+ =	${WRKSRC}/license.txt
LICENSE_FILE_ISCL=	${WRKSRC}/externals/cubeb/LICENSE

BROKEN_aarch64=	build fails on aarch64 with system boost-libs

BUILD_DEPENDS=	boost-libs>0:devel/boost-libs \
		nlohmann-json>0:devel/nlohmann-json \
		cpp-httplib>0:www/cpp-httplib \
		glslang>0:graphics/glslang \
		vulkan-headers>0:graphics/vulkan-headers

LIB_DEPENDS=	libCatch2.so:devel/catch2 \
		libfmt.so:devel/libfmt \
		libinih.so:devel/inih \
		libSoundTouch.so:audio/soundtouch \
		libenet.so:net/enet

USE_GITHUB=	yes
GH_ACCOUNT=	azahar-emu
GH_TAGNAME=	2124
GH_TUPLE=	neobrain:nihstro:f4d8659decbfe5d234f04134b5002b82dc515a44:nihstro/externals/nihstro \
		azahar-emu:dynarmic:526227eebe1efff3fb14dbf494b9c5b44c2e9c1f:dynarmic/externals/dynarmic \
		herumi:xbyak:v3.71-1460-g0d67fd1:xbyak/externals/xbyak \
        	mozilla:cubeb:832fcf38e600bf80b4b728a3e0227403088d992c:cubeb/externals/cubeb \
        	arun11299:cpp-jwt:4a970bc302d671476122cbc6b43cc89fbf4a96ec:cppjwt/externals/cpp-jwt \
		wwylele:teakra:3d697a18df504f4677b65129d9ab14c7c597e3eb:teakra/externals/teakra \
		lvandeve:lodepng:0b1d9ccfc2093e5d6620cd9a11d03ee6ff6705f5:lodepng/externals/lodepng/lodepng \
		facebook:zstd:v1.5.7:zstd/externals/zstd \
        	lemenkov:libyuv:6f729fbe658a40dfd993fa8b22bd612bb17cde5c:libyuv/externals/libyuv \
		abdes:cryptopp-cmake:CRYPTOPP_8_9_0-20-g00a151f:cryptoppcmake/externals/cryptopp-cmake \
		weidai11:cryptopp:CRYPTOPP_8_9_0-19-g60f81a77:cryptopp/externals/cryptopp \
        	septag:dds-ktx:c3ca8febc2457ab5c581604f3236a8a511fc2e45:ddsktx/externals/dds-ktx \
        	GPUOpen-LibrariesAndSDKs:VulkanMemoryAllocator:v2.1.0-933-gc788c52:VulkanMemoryAllocator/externals/vma \
		azahar-emu:sirit:37d49d2aa4c0a62f872720d6e5f2eaf90b2c95fa:sirit/externals/sirit/sirit \
        	knik0:faad2:216f00e8ddba6f2c64caf481a04f1ddd78b93e78:faad2/externals/faad2/faad2 \
        	azahar-emu:ext-library-headers:3b3e28dbe6d033395ce2967fa8030825e7b89de7:extlibraryheaders/externals/library-headers \
        	merryhime:oaknut:6b1d57ea7ed4882d32a91eeaa6557b0ecb4da152:oaknut/externals/oaknut \
		azahar-emu:compatibility-list:eadcdfb84b6f3b95734e867d99fe16a9e8db717f:compatibilitylist/dist/compatibility_list \
        	KhronosGroup:SPIRV-Tools:v2022.4-759-ga62abcb4:SPIRVTools/externals/spirv-tools \
        	KhronosGroup:SPIRV-Headers:1.5.4.raytracing.fixed-411-gaa6cef1:SPIRVHeaders/externals/spirv-headers \
        	arsenm:sanitizers-cmake:aab6948fa863bc1cbe5d0850bc46b9ef02ed4c1a:sanitizerscmake/externals/cubeb/cmake/sanitizers-cmake \
		azahar-emu:mcl:5fc4beaf331037649b10625736b41365defb4f50:mcl/externals/dynarmic/externals/mcl \
		Tessil:robin-map:054ec5ad67440fcd65e0497e5a27ef31f53fcc7f:robinmap/externals/dynarmic/externals/robin-map \
		zyantific:zycore-c:0b2432ced0884fd152b471d97ecf0258ff4d859f:zycorec/externals/dynarmic/externals/zycore \
		zyantific:zydis:bffbb610cfea643b98e87658b9058382f7522807:zydis/externals/dynarmic/externals/zydis \
		Cyan4973:xxHash:e626a72bc2321cd320e953a0ccf1584cad60f363:xxHash/externals/xxHash

USES=		cmake:testing compiler:c++17-lang localbase:ldflags pkgconfig \
		sdl
USE_SDL=	sdl2
CMAKE_ON=	USE_SYSTEM_BOOST Boost_USE_STATIC_LIBS USE_SYSTEM_CATCH2 \
		USE_SYSTEM_FMT USE_SYSTEM_INIH USE_SYSTEM_SOUNDTOUCH \
		USE_SYSTEM_SDL2 USE_SYSTEM_ENET USE_SYSTEM_JSON \
		USE_SYSTEM_OPENSSL USE_SYSTEM_CPP_HTTPLIB USE_SYSTEM_GLSLANG \
		USE_SYSTEM_VULKAN_HEADERS USE_SYSTEM_FFMPEG_HEADERS
LDFLAGS+=	-Wl,--as-needed

OPTIONS_DEFINE=		ALSA FFMPEG JACK PULSEAUDIO QT6 SDL SNDIO VULKAN
OPTIONS_DEFAULT=	FFMPEG JACK PULSEAUDIO QT6 SDL SNDIO VULKAN

CMAKE_ARGS+=		-DENABLE_OPENAL:BOOL=OFF \
			-DENABLE_LIBUSB:BOOL=OFF 

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

VULKAN_DESC=		Vulkan renderer (experimental)
VULKAN_BUILD_DEPENDS=	vulkan-headers>0:graphics/vulkan-headers
VULKAN_CMAKE_BOOL=	ENABLE_VULKAN

SDL_CMAKE_BOOL=	ENABLE_SDL2

QT6_USES=	desktop-file-utils qt:6 shared-mime-info
USE_QT+=	base multimedia tools
QT6_CMAKE_BOOL=	ENABLE_QT ENABLE_QT_TRANSLATION

.include <bsd.port.pre.mk>

post-patch:
	@${REINPLACE_CMD} -e 's/@GIT_BRANCH@/master/' \
		-e 's/@GIT_DESC@/${GH_TAGNAME}/' \
		-e 's/@BUILD_FULLNAME@/${PORTVERSION}/' \
		${WRKSRC}/src/common/scm_rev.cpp.in

.include <bsd.port.post.mk>
