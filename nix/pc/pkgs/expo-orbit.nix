{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  cairo,
  cups,
  dbus,
  expat,
  glib,
  gtk3,
  libdrm,
  libgbm,
  libGL,
  libnotify,
  libxkbcommon,
  nspr,
  nss,
  pango,
  systemd,
  xdg-utils,
  xorg,
}:

# Expo Orbit isn't in nixpkgs; this repackages the upstream .deb, which bundles
# its own Electron.
stdenv.mkDerivation rec {
  pname = "expo-orbit";
  version = "2.8.1";

  src = fetchurl {
    url = "https://github.com/expo/orbit/releases/download/expo-orbit-v${version}/expo-orbit_${version}_amd64.deb";
    hash = "sha256-FhfExImaFTHEyK5zqeuExvlFLWECZ16Gk2DBGFlVc0g=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    dbus
    expat
    glib
    gtk3
    libdrm
    libgbm
    libxkbcommon
    nspr
    nss
    pango
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
  ];

  unpackPhase = ''
    runHook preUnpack
    # chrome-sandbox is setuid in the .deb, which the build sandbox refuses
    dpkg-deb --fsys-tarfile $src | tar -x --no-same-owner --no-same-permissions
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib $out/bin
    cp -r usr/lib/expo-orbit $out/lib/
    cp -r usr/share $out/share

    # Native node modules ship prebuilds for every platform; keep linux-x64 only
    # so autoPatchelf doesn't chase Android/arm64 libraries.
    find $out/lib/expo-orbit/resources/app/node_modules -type d -path '*/prebuilds/*' \
      -prune ! -name linux-x64 -exec rm -rf {} +

    # Loaded with dlopen, so autoPatchelf can't see them.
    makeWrapper $out/lib/expo-orbit/expo-orbit $out/bin/expo-orbit \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          libGL
          libnotify
          systemd
        ]
      } \
      --prefix PATH : ${lib.makeBinPath [ xdg-utils ]} \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"

    runHook postInstall
  '';

  meta = {
    description = "One-click build launches and simulator management from your menu bar";
    homepage = "https://github.com/expo/orbit";
    license = lib.licenses.mit;
    mainProgram = "expo-orbit";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
