function upkg
    if not set -q argv[1]
        echo 'Error: package name required' >&2
        return 1
    end

    set pkg_dir /home/crabvk/pkg
    set pkg_name $argv[1]
    set pattern "^$pkg_name-[\d\.]+.+\.pkg\.tar\.[^\.]+\$"

    set pkg_file_old (fd -utf $pattern $pkg_dir)
    set pkg_file_new (fd -utf $pattern)
    set count_old (count $pkg_file_old)
    set count_new (count $pkg_file_new)

    if test $count_old -eq 0
        echo 'Warning: old package file not found' >&2
    end

    if test $count_old -gt 1
        echo 'Error: more than 1 old package files found' >&2
        return 2
    end

    if test $count_new -eq 0
        echo 'Warning: new package file not found' >&2
    end

    if test $count_new -eq 1
        rm -f $pkg_file_old
        mv $pkg_file_new $pkg_dir
        sudo pacman -U $pkg_dir/$pkg_file_new
    end
end
