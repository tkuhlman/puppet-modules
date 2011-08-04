# This facter reciple pulls mount definitions from /etc/fstab
# This is intended to be more general fstab info one day, for now I just ext mounts.

Facter.add("ext_mounts") do
    setcode do
        File.new('/etc/fstab').readlines.collect do |line|
            matches = line.match('\S*\s*(\S*)\s*ext.*')
            if matches.nil?
                nil
            else
                matches[1]
            end
        end.flatten.uniq.compact.sort.join(" ")
    end
end

Facter.add("ext_devs") do
    setcode do
        File.new('/etc/fstab').readlines.collect do |line|
            matches = line.match('(\S*)\s*\S*\s*ext.*')
            if matches.nil?
                nil
            else
                matches[1]
            end
        end.flatten.uniq.compact.sort.join(" ")
    end
end

Facter.add("xfs_mounts") do
    setcode do
        File.new('/etc/fstab').readlines.collect do |line|
            matches = line.match('\S*\s*(\S*)\s*xfs.*')
            if matches.nil?
                nil
            else
                matches[1]
            end
        end.flatten.uniq.compact.sort.join(" ")
    end
end

