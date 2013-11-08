# Fact: vmalloc
#
# Purpose: Return information about vmalloc memory.
#
# Resolution:
#   On Linuxes, uses Facter::Memory.meminfo_number from
#   'facter/util/memory.rb'
#
# Caveats:
#
# vmalloc.rb
# Additional Facts for vmalloc usage
#
# Copyright (C) 2013 CloudHealth Tech
# Author: Steven Frank <steve@cloudhealthtech.com>
#

require 'facter/util/memory'

%w(vmalloctotal vmallocused).each do |fact|
  Facter.add(fact) do
    setcode do
      name = Facter.fact(fact + "_mb").value
      Facter::Memory.scale_number(name.to_f, "MB") if name
    end
  end
end

#Facter.add("vmalloctotal_mb") do
#  setcode do
#    vmalloctotal = Facter::Memory.vmalloc_total
#    "%.2f" % [vmalloctotal] if vmalloctotal
#  end
#end
#
#Facter.add("vmallocused_mb") do
#  setcode do
#    vmallocused = Facter::Memory.vmalloc_used
#    "%.2f" % [vmallocused] if vmallocused
#  end
#end

{vmalloctotal_mb: 'VmallocTotal', vmallocused_mb: 'VmallocUsed'}.each do |fact, name|
  Facter.add(fact) do
    confine :kernel => [ :linux, :'gnu/kfreebsd']
    setcode do
      meminfo = Facter::Memory.meminfo_number(name)
      '%.2f' % [meminfo]
    end
  end
end
