$pkg_name="visual-build-tools-2017"
$pkg_origin="core"
$pkg_version="15"
$pkg_description="Standalone compiler, libraries and scripts"
$pkg_upstream_url="https://www.visualstudio.com/downloads/#build-tools-for-visual-studio-2017"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/5/A/8/5A8B8314-CA70-4225-9AF0-9E957C9771F7/vs_BuildTools.exe"
$pkg_shasum="e77d433c44f3d0cbf7a3efa497101de93918c492c2ebcaec79a1faf593d419bc"

$pkg_bin_dirs=@(
  "Contents\VC\Tools\MSVC\14.10.25017\bin\HostX64\x64",
  "Contents\VC\Redist\MSVC\14.10.25008\x64\Microsoft.VC150.CRT",
  "Contents\MSBuild\15.0\Bin\amd64"
)
$pkg_lib_dirs=@(
  "Contents\VC\Tools\MSVC\14.10.25017\atlmfc\lib\x64",
  "Contents\VC\Tools\MSVC\14.10.25017\lib\x64"
)
$pkg_include_dirs=@(
  "Contents\VC\Tools\MSVC\14.10.25017\atlmfc\include",
  "Contents\VC\Tools\MSVC\14.10.25017\include"
)

function Invoke-Unpack {
  Start-Process "$HAB_CACHE_SRC_PATH/$pkg_filename" -Wait -ArgumentList "--passive --layout $HAB_CACHE_SRC_PATH/$pkg_dirname --lang en-US"
  Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  try {
    Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Include *.vsix -Exclude @('*x86*', '*.arm.*') -Recurse | % {
      Rename-Item $_ "$_.zip"
      Expand-Archive "$_.zip" expanded -force
    }
  }
  finally { Pop-Location }
}

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_dirname\expanded\Contents" $pkg_prefix -Force -Recurse
}
