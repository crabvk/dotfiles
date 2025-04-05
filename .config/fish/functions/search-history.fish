function search-history
    set item (history | sk --tac --no-sort)
    set code $status

    if test $code -eq 0
        commandline -r $item
    else
        return $code
    end
end
