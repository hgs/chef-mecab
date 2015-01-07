#
# Cookbook Name:: mecab
# Recipe:: default
#
# Copyright (C) 2014 hgs
#
# MIT License
#


base_dir   = "#{Chef::Config['file_cache_path'] || '/tmp'}/"
mecab_file = "mecab-#{node['mecab']['version']}.tar.gz"
mecab_url  = "https://mecab.googlecode.com/files/" + mecab_file
mecab_path = base_dir + mecab_file
patch_file = 'request_type.patch'
patch_path = base_dir + patch_file

ipadic_file  = "mecab-ipadic-#{node['mecab']['ipadic']['version']}.tar.gz"
ipadic_url   = "https://mecab.googlecode.com/files/" + ipadic_file
ipadic_path  = base_dir + ipadic_file


# install packages
%w{ g++ }.each do |pack|
  package pack
end

# get tar.gz of mecab
remote_file mecab_path do
  source mecab_url
  checksum node['mecab']['checksum']
  backup false
end

# get tar.gz of ipadic
remote_file ipadic_path do
  source ipadic_url
  checksum node['mecab']['ipadic']['checksum']
  backup false
end

# locate patch file
cookbook_file patch_file do
  path patch_path
  backup false
end


execute 'compile_and_install_patched_mecab' do
  cwd ::File.dirname(patch_path)
  command <<-EOH
    tar xzf #{mecab_file}
    patch mecab-#{node['mecab']['version']}/src/tagger.cpp < #{patch_file}
    (cd mecab-#{node['mecab']['version']} && ./configure --enable-utf8-only && make && make install)
  EOH
end

if node['platform'] == 'ubuntu'
  execute 'ldconfig'
end

execute 'install_dict' do
  cwd ::File.dirname(ipadic_path)
  command <<-EOH
    tar xzf #{ipadic_file}
    (cd mecab-ipadic-#{node['mecab']['ipadic']['version']} && ./configure --with-charset=utf-8 && make && make install)
  EOH
end

# if node['platform'] == 'ubuntu'
#   execute 'ldconfig'
# end
