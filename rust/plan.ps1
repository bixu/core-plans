﻿$pkg_name="rust"
$pkg_origin="core"
$pkg_version="1.29.2"
$pkg_description="Safe, concurrent, practical language"
$pkg_upstream_url="https://www.rust-lang.org/"
$pkg_license=@("Apache-2.0", "MIT")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://static.rust-lang.org/dist/rust-$pkg_version-x86_64-pc-windows-msvc.msi"
$pkg_shasum="ec7ad1a69f5708dccf72c0296292985cf1ed8e10bdd002a3a5e2f28453975e82"
$pkg_deps=@("core/visual-cpp-redist-2013", "core/visual-cpp-build-tools-2015")
$pkg_build_deps=@("core/lessmsi")
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")

function Invoke-Unpack {
  lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_filename").Path
  mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  Move-Item "rust-$pkg_version-x86_64-pc-windows-msvc/SourceDir/Rust" "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/Rust/*" "$pkg_prefix" -Recurse -Force
}

function Invoke-Check() {
  (& "$HAB_CACHE_SRC_PATH/$pkg_dirname/Rust/bin/rustc.exe" --version).StartsWith("rustc $pkg_version")
}
