class apache::default_mods (
  $all  = true,
  $mods = undef,
) {
  # These are modules required to run the default configuration.
  # They are not configurable at this time, so we just include
  # them to make sure it works.
  case $::osfamily {
    'redhat', 'freebsd': {
      apache::mod { 'log_config': }
    }
    default: {}
  }
  apache::mod { 'authz_host': }

  # The rest of the modules only get loaded if we want all modules enabled
  if $all {
    case $::osfamily {
      'debian': {
        include apache::mod::reqtimeout
      }
      'redhat': {
        include apache::mod::cache
        include apache::mod::mime
        include apache::mod::mime_magic
        include apache::mod::vhost_alias
        include apache::mod::rewrite
        apache::mod { 'actions': }
        apache::mod { 'auth_digest': }
        apache::mod { 'authn_alias': }
        apache::mod { 'authn_anon': }
        apache::mod { 'authn_dbm': }
        apache::mod { 'authn_default': }
        apache::mod { 'authz_dbm': }
        apache::mod { 'authz_owner': }
        apache::mod { 'expires': }
        apache::mod { 'ext_filter': }
        apache::mod { 'include': }
        apache::mod { 'logio': }
        apache::mod { 'speling': }
        apache::mod { 'substitute': }
        apache::mod { 'suexec': }
        apache::mod { 'usertrack': }
        apache::mod { 'version': }
      }
      'freebsd': {
        include apache::mod::cache
        include apache::mod::disk_cache
        include apache::mod::headers
        include apache::mod::info
        include apache::mod::mime_magic
        include apache::mod::reqtimeout
        include apache::mod::rewrite
        include apache::mod::userdir
        include apache::mod::vhost_alias

        apache::mod { 'actions': }
        apache::mod { 'asis': }
        apache::mod { 'auth_digest': }
        apache::mod { 'authn_alias': }
        apache::mod { 'authn_anon': }
        apache::mod { 'authn_dbm': }
        apache::mod { 'authn_default': }
        apache::mod { 'authz_dbm': }
        apache::mod { 'authz_owner': }
        apache::mod { 'cern_meta': }
        apache::mod { 'charset_lite': }
        apache::mod { 'dumpio': }
        apache::mod { 'expires': }
        apache::mod { 'file_cache': }
        apache::mod { 'filter':}
        apache::mod { 'imagemap':}
        apache::mod { 'include': }
        apache::mod { 'logio': }
        apache::mod { 'speling': }
        apache::mod { 'unique_id': }
        apache::mod { 'usertrack': }
        apache::mod { 'version': }
      }
      default: {}
    }
    case $apache::mpm_module {
      'prefork': {
        include apache::mod::cgi
      }
      'worker': {
        include apache::mod::cgid
      }
      default: {
        # do nothing
      }
    }
    include apache::mod::alias
    include apache::mod::autoindex
    include apache::mod::dav
    include apache::mod::dav_fs
    include apache::mod::deflate
    include apache::mod::dir
    include apache::mod::mime
    include apache::mod::negotiation
    include apache::mod::setenvif
    apache::mod { 'auth_basic': }
    apache::mod { 'authn_file': }
    apache::mod { 'authz_default': }
    apache::mod { 'authz_groupfile': }
    apache::mod { 'authz_user': }
    apache::mod { 'env': }
  } elsif $mods {
    apache::default_mods::load { $mods: }
  }
}
