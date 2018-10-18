pkg_name=redis
pkg_dist_name=redis
pkg_origin=core
pkg_version="4.0.10"
pkg_description="Persistent key-value database, with built-in net interface"
pkg_upstream_url="http://redis.io/"
pkg_license=("BSD-3-Clause")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://download.redis.io/releases/${pkg_dist_name}-${pkg_version}.tar.gz"
pkg_shasum="1db67435a704f8d18aec9b9637b373c34aa233d65b6e174bdac4c1b161f38ca4"
pkg_bin_dirs=(bin)
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_deps=(core/glibc)
pkg_svc_run="redis-server ${pkg_svc_config_path}/redis.config"
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

do_build() {
  make
}
