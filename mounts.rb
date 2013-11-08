# Fact: mounts
#
# Purpose: Return information about mount points.
#
# Resolution:
#
# Caveats:
#
# mounts.rb
# Additional Facts for mount points
#
# Copyright (C) 2013 CloudHealth Tech
# Author: Steven Frank <steve@cloudhealthtech.com>
#

require 'json'

has_fs_gem = true
begin
  require 'sys/filesystem'
rescue LoadError
  has_fs_gem = false
end
include Sys if has_fs_gem

Facter.add(:mounts) do
  mounts = []
  if has_fs_gem
    setcode do
      Filesystem.mounts {|mount|
        s = Filesystem.stat(mount.mount_point)
        mounts << {
          fs:        mount.name,
          type:      mount.mount_type,
          total:     s.blocks * 4096,
          used:      (s.blocks - s.blocks_free) * 4096,
          available: s.blocks_available * 4096,
          mount:     mount.mount_point,
          options:   mount.options
        }
      }
      JSON.generate mounts
    end
  else
    confine :kernel => [:linux, :'gnu/kfreebsd']
    setcode do
      output = Facter::Util::Resolution.exec('df -a -P -T -B 1 2>/dev/null').split("\n")
      return JSON.generate(mounts) if output.length <= 1
      mount_options = {}
      begin
        Facter::Util::Resolution.exec('mount 2>/dev/null').split("\n").each {|line|
          next unless line =~ /^(.+?) on (.+?) type (.+?) \((.+?)\)$/
          mount_options[$2] = $4.split(',')
        }
      rescue => ex
        $stderr.puts ex.message
        #we simply won't return mount option values
      end
      output.shift #Trim Header
      output.each {|m|
        parts = m.match(/^(.+?)\s+(.+?)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+\%|\-)\s+(.+)$/)
        next unless parts.length >= 8
        mounts << {
          fs:        parts[1],
          type:      parts[2],
          total:     parts[3],
          used:      parts[4],
          available: parts[5],
          mount:     parts[7],
          options:   mount_options[parts[7]]
        }
      }
      JSON.generate mounts
    end
  end
end
