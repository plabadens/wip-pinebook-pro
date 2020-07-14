final: super:

let
  inherit (final) callPackage kernelPatches linuxPackagesFor;
in
{
  # Alternative BSP u-boot, with nvme support if desired
  #   * https://gitlab.manjaro.org/manjaro-arm/packages/core/uboot-pinebookpro
  uBootPinebookPro = callPackage ./u-boot {};
  uBootPinebookProExternalFirst = callPackage ./u-boot {
    externalFirst = true;
  };

  # The unqualified kernel attr is deprecated.
  linux_pinebookpro = throw "The linux_pinebookpro attribute has been replaced by linux_pinebookpro_latest.";
  linuxPackages_pinebookpro = throw "The linuxPackages_pinebookpro attribute has been replaced by linuxPackages_pinebookpro_latest.";

  linux_pinebookpro_latest = callPackage ./kernel/latest {
    kernelPatches = [
      kernelPatches.bridge_stp_helper
      kernelPatches.export_kernel_fpu_functions."5.3"
    ];
  };
  linuxPackages_pinebookpro_latest = linuxPackagesFor final.linux_pinebookpro_latest;

  pinebookpro-firmware = callPackage ./firmware {};
  pinebookpro-keyboard-updater = callPackage ./keyboard-updater {};
}
