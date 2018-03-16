self: super:
let
  aspellWithDict = super.aspellWithDicts(ps: with ps; [ en ]);
in {
  emacsHeadCustom = with super; stdenv.lib.overrideDerivation emacsHEAD (attrs: rec {
    appName = "Emacs";
    bundleName = "nextstep/Emacs.app";
    iconFile = ./emacs/spacemacs.icns;

    # TODO postPath and postInstall reuse

    # From jwiegley/nix-config/overlays/10-emacs.nix
    postPatch = ''
      sed -i 's|/usr/share/locale|${gettext}/share/locale|g' \
        lisp/international/mule-cmds.el
      sed -i 's|nextstep/Emacs\.app|${bundleName}|' configure.ac
      sed -i 's|>Emacs<|>${appName}<|' nextstep/templates/Info.plist.in
      sed -i 's|Emacs\.app|${appName}.app|' nextstep/templates/Info.plist.in
      sed -i 's|org\.gnu\.Emacs|org.gnu.${appName}|' nextstep/templates/Info.plist.in
      sed -i 's|Emacs @version@|${appName} @version@|' nextstep/templates/Info.plist.in
      sed -i 's|EmacsApp|${appName}App|' nextstep/templates/Info.plist.in
      if [ -n "${iconFile}" ]; then
        sed -i 's|Emacs\.icns|${appName}.icns|' nextstep/templates/Info.plist.in
      fi
      sed -i 's|Name=Emacs|Name=${appName}|' nextstep/templates/Emacs.desktop.in
      sed -i 's|Emacs\.app|${appName}.app|' nextstep/templates/Emacs.desktop.in
      sed -i 's|"Emacs|"${appName}|' nextstep/templates/InfoPlist.strings.in
      rm -fr .git
      sh autogen.sh
    '';

    # From jwiegley/nix-config/overlays/10-emacs.nix
    postInstall = ''
      mkdir -p $out/share/emacs/site-lisp
      cp ${./emacs/site-start.el} $out/share/emacs/site-lisp/site-start.el
      $out/bin/emacs --batch -f batch-byte-compile $out/share/emacs/site-lisp/site-start.el

      rm -rf $out/var
      rm -rf $out/share/emacs/${emacsHEAD.version}/site-lisp

      for srcdir in src lisp lwlib ; do
        dstdir=$out/share/emacs/${emacsHEAD.version}/$srcdir
        mkdir -p $dstdir
        find $srcdir -name "*.[chm]" -exec cp {} $dstdir \;
        cp $srcdir/TAGS $dstdir
        echo '((nil . ((tags-file-name . "TAGS"))))' > $dstdir/.dir-locals.el
      done

      mkdir -p $out/Applications
      if [ "${appName}" != "Emacs" ]; then
          mv ${bundleName}/Contents/MacOS/Emacs ${bundleName}/Contents/MacOS/${appName}
      fi
      if [ -n "${iconFile}" ]; then
        cp "${iconFile}" ${bundleName}/Contents/Resources/${appName}.icns
      fi
      mv ${bundleName} $out/Applications
    '';

  });
}
