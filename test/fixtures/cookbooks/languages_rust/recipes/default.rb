
#########################################################################
# Basic Install with Execution
#########################################################################
rust_install '1.3.0'

project_path = ::File.join(Chef::Config[:file_cache_path], 'fake')

rust_execute 'cargo new fake' do
  version '1.3.0'
  cwd Chef::Config[:file_cache_path]
  not_if { ::File.exist?(project_path) }
end

file ::File.join(project_path, 'Cargo.toml') do
  content <<-EOF
[package]
name = "fake"
version = "0.0.1"
authors = ["Fakey McFake <fake@chef.io>"]

[dependencies]
regex = "*"
  EOF
  sensitive true
  action :create
end

rust_execute 'cargo build' do
  version '1.3.0'
  cwd project_path
end

#########################################################################
# Non-default Prefix
#########################################################################
if Chef::Platform.windows?
  alternate_prefix = 'C:/rust'
else
  alternate_prefix = '/usr/local'
end

rust_install '2015-07-31' do
  channel 'beta'
  prefix alternate_prefix
end

#########################################################################
# Channel Attribute
#########################################################################
rust_install '2015-10-03' do
  channel 'nightly'
end
