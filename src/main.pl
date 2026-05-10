% File utama program
% fitur startGame (Bintang & Neysa)
startGame :-
    % bersihin state dari sisa game sebelumnya (kalau ada)
    retractall(urutan_pemain(_)),
    retractall(giliran_sekarang(_)),
    retractall(efek_kartu(_)),

    % minta input jumlah sm nama pemain
    input_jumlah_pemain(N),
    input_nama_pemain(N, [], ListPemain),

    % simpan data ke state game
    asserta(urutan_pemain(ListPemain)),
    ListPemain = [PemainPertama|_], 
    asserta(giliran_sekarang(PemainPertama)),
    asserta(efek_kartu(none)),

    % feedback ke terminal biar tau sukses
    nl, write('Game disetup!'), nl,
    format('Pemain: ~w~n', [ListPemain]),
    format('Giliran awal: ~w~n', [PemainPertama]),
    nl.
    % TODO : neyyy, logic buat ngacak deck sm bagiin kartu ke tangan_pemain ditaro di bawah sini yakkzz

% helper bwt minta input jumlah pemain (batas 2-4)
input_jumlah_pemain(N) :-
    write('Berapa pemain (2-4)? [pake titik]: '),
    read(Input),
    (   integer(Input), Input >= 2, Input =< 4
    ->  N = Input
    ;   write('Sumbang euy, masukin angka 2, 3, atau 4 aja!'), nl,
        input_jumlah_pemain(N) % ngulang kalo sala input
    ).

% helper bwt minta nama pemain unik
input_nama_pemain(0, Acc, Acc) :- !. % base case: kalo udah pas, balikin listnya
input_nama_pemain(N, Acc, ListPemain) :-
    N > 0,
    write('Masukin nama pemain [pake titik]: '),
    read(Nama),
    (   member(Nama, Acc) % cek nama kembar
    ->  write('Namanya udah dipake, cari nama lain ngab!'), nl,
        input_nama_pemain(N, Acc, ListPemain)
    ;   N1 is N - 1,
        append(Acc, [Nama], AccBaru), % masukin nama ke list sementara
        input_nama_pemain(N1, AccBaru, ListPemain)
    ).
