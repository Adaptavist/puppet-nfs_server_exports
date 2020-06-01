require 'spec_helper'
 
describe 'nfs_server_exports', :type => 'class' do

    export_1_name = 'test_export_1'
    export_1_line = '/mnt/export1 192.168.12.1 (rw,sync,no_root_squash,no_all_squash)'
    export_2_name = 'test_export_2'
    export_2_line = '/mnt/export2 192.168.12.2 (ro)'
    exports_hash = {
	        export_1_name => export_1_line,
	        export_2_name => export_2_line,
    }

    exports_path = "/etc/exports"
    refresh_exec = "update_nfs_exports"
    clear_exports_exec = "clear_exports_file_content"

    context "should create exports, reload the list and remove any unmanaged values" do
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
        :refresh_exports_exec => refresh_exec,
        :manage_all_exports => true
      }
    }

    it { should contain_class('nfs')}

    it { should contain_exec(clear_exports_exec).with(
      :command => "echo '' > #{exports_path}",
      :require => "File[nfs_exports]",
      :notify  => "Exec[#{refresh_exec}]"
    )}

    it { should contain_file_line(export_1_name).with(
      :path    => exports_path,
      :line    => export_1_line,
      :require => "Exec[#{clear_exports_exec}]"
    )}

     it { should contain_file_line(export_2_name).with(
      :path    => exports_path,
      :line    => export_2_line,
      :require => "Exec[#{clear_exports_exec}]"
    )}


    end

    context "should create exports, reload the list and keep any unmanaged values" do
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
        :refresh_exports_exec => refresh_exec,
        :manage_all_exports => false
      }
    }

    it { should contain_class('nfs')}

    it { should_not contain_exec(clear_exports_exec)}

    it { should contain_file_line(export_1_name).with(
      :path    => exports_path,
      :line    => export_1_line,
      :require => "File[nfs_exports]"
    )}

     it { should contain_file_line(export_2_name).with(
      :path    => exports_path,
      :line    => export_2_line,
      :require => "File[nfs_exports]"
    )}


    end

   context "should NOT create any new exports, reload the list and keep any unmanaged values" do
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
      { :exports => :undef,
        :exports_path => exports_path,
        :refresh_exports_exec => refresh_exec,
        :manage_all_exports => false
      }
    }

    it { should contain_class('nfs')}

    it { should_not contain_exec(clear_exports_exec)}

    end

   context "should NOT create any exports, reload the list and remove any unmanaged values" do
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
      { :exports => :undef,
        :exports_path => exports_path,
        :refresh_exports_exec => refresh_exec,
        :manage_all_exports => true
      }
    }

    it { should contain_class('nfs')}

    it { should contain_exec(clear_exports_exec).with(
      :command => "echo '' > #{exports_path}",
      :require => "File[nfs_exports]",
      :notify  => "Exec[#{refresh_exec}]"
    )}

    end

end