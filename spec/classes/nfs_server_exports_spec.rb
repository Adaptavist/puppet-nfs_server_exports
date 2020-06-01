require 'spec_helper'
 
describe 'nfs_server_exports', :type => 'class' do

    export_1_name = 'test_export_1'
    export_1_line = '/mnt/export1 192.168.12.1 (rw,sync,no_root_squash,no_all_squash)'
    export_2_name = 'test_export_2'
    export_2_line = '/mnt/export2 192.168.12.2 (ro)'
    exports_hash = {
	        export_1_name => export_1_line ,
	        export_2_name => export_2_line,
    }
    refresh_cmd = "exportfs -ra"
    exports_path = "/etc/exports"


    context "should create exports and reload list" do
    let(:facts) {
      { :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemrelease => '7.0',
        :operatingsystemmajrelease => '7',
        :concat_basedir => '/tmp',
        :kernel => 'Linux',
        :id => 'root',
        :path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      }
    }
    let(:params) {
      { :exports => exports_hash,
        :exports_path => exports_path,
        :refresh_exports_cmd => refresh_cmd,
      }
    }

    it { should contain_class('nfs')}


    it { should contain_file_line(export_1_name).with(
      :path   => exports_path,
      :line   => export_1_line,
    )}

     it { should contain_file_line(export_2_name).with(
      :path   => exports_path,
      :line   => export_2_line,
    )}

    it { is_expected.to contain_exec('refresh_exports').with(
      :command => refresh_cmd,
      :refreshonly => true,
    )}
    

    end

end