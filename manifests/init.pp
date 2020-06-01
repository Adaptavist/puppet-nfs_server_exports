# This class is designed to extend the ghoneycutt/puppet-module-nfs modules functionality, it is 
# NOT designed to be run as standalone

class nfs_server_exports (
    Variant[Undef, Hash]   $exports              = undef,
    Stdlib::Absolutepath   $exports_path         = $nfs::exports_path,
    String                 $refresh_exports_exec = 'update_nfs_exports',
    Boolean                $manage_all_exports   = true,
    ) {

    # include the NFS class
    include ::nfs

    # if this module manages ALL exports clear the export file before proceeding
    if $manage_all_exports == true{
        exec{'clear_exports_file_content':
            command => "echo '' > ${exports_path}",
            require => File['nfs_exports'],
            # notify the nfs exports refresh command from the parent nfs module
            notify  => Exec[$refresh_exports_exec],
        }
        $exports_require = 'Exec[clear_exports_file_content]'
    } else {
        $exports_require = 'File[nfs_exports]'
    }

    # if exports is not undefined attempt to create the required entries 
    if $exports != undef {

        # loop through the hash and create the exports
        $exports.each |$key,$value| {
            file_line { $key:
                path    => $exports_path,
                line    => $value,
                # notify the nfs exports refresh command from the parent nfs module
                notify  => Exec[$refresh_exports_exec],
                require => $exports_require,
            }
        }
    }
}
