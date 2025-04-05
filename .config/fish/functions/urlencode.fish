function urlencode
  set str (string join ' ' $argv)

  for c in (string split '' $str)
    if string match -qr '[a-zA-Z0-9.~_-]' $c
      env LC_COLLATE=C printf "$c"
    else
      env LC_COLLATE=C printf '%%%02X' "'$c" 2>/dev/null
    end
  end
end

