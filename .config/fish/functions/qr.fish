function qr
    qrencode -s 20 -m 1 -o - -- "$argv" | magick png:- sixel:-
end
