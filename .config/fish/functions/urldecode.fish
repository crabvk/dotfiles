function urldecode
    set url_encoded (string replace -a '+' ' ' $argv[1])
    printf '%b' (string replace -a '%' '\\x' $url_encoded)
end
