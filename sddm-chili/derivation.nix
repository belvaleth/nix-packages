{ lib, stdenv, qtgraphicaleffects, themeConfig ? { } }
:
let
  customToString = x: if builtins.isBool x then lib.boolToString x else toString x;
  configLines = lib.mapAttrsToList (name: value: lib.nameValuePair name value) themeConfig;
  configureTheme = "cp theme.conf theme.conf.orig \n" +
    (lib.concatMapStringsSep "\n"
      (configLine:
        "grep -q '^${configLine.name}=' theme.conf || echo '${configLine.name}=' >> \"$1\"\n" +
          "sed -i -e 's/^${configLine.name}=.*$/${configLine.name}=${
        lib.escape [ "/" "&" "\\"] (customToString configLine.value)
      }/' theme.conf"
      )
      configLines);
in
stdenv.mkDerivation {
  pname = "sddm-chili-theme";
  version = "0.1.5";

  src = /home/jstewart/packages/sddm-chili;

  propagatedBuildInputs = [
    qtgraphicaleffects
  ];

  dontWrapQtApps = true;

  preInstall = configureTheme;

  postInstall = ''
    mkdir -p $out/share/sddm/themes/chili

    mv * $out/share/sddm/themes/chili/
  '';

  postFixup = ''
    mkdir -p $out/nix-support

    echo ${qtgraphicaleffects} >> $out/nix-support/propagated-user-env-packages
  '';
}
