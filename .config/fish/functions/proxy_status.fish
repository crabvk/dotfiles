function proxy_status
    ip link show tun0 > /dev/null 2>&1
    if test $status -eq 0
        echo ⚡
    end
end
