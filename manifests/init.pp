class nfs_server_exports (
    Variant[Undef, Hash]   $exports             = undef,
    Stdlib::Absolutepath   $exports_path        = '/etc/exports',
    String                 $refresh_exports_cmd = 'exportfs -ra',
    ) {

    # if exports is not undefined attempt to create the required entries
    if $exports != undef {

        # include the NFS class
        include ::nfs

        # loop through the hash and create the exports
        $exports.each |$key,$value| {
            file_line { $key:
                path   => $exports_path,
                line   => $value,
                notify => Exec['refresh_exports'],
            }
        }

        # reload the exports
        exec { 'refresh_exports':
            command     => $refresh_exports_cmd,
            refreshonly => true,
        }
    }
}
