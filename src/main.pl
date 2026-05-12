% File utama program
% fitur startGame (Bintang & Neysa)

:- include('file1.pl').

startGame :-
    % bersihin state dari sisa game sebelumnya (kalau ada)
    retractall(urutan_pemain(_)),
    retractall(giliran_sekarang(_)),
    retractall(efek_kartu(_)),
    retractall(deck_kartu(_)),
    retractall(discard_top(_)),
    retractall(warna_aktif(_)),
    retractall(tangan_pemain(_, _)),

    % minta input jumlah sm nama pemain
    input_jumlah_pemain(N),
    input_nama_pemain(N, [], ListPemain),

    % simpan data ke state game
    asserta(urutan_pemain(ListPemain)),
    ListPemain = [PemainPertama|_], 
    asserta(giliran_sekarang(PemainPertama)),
    asserta(efek_kartu(none)),

    % feedback ke terminal biar tau sukses
    nl, write('⠀⠀⠀⠀⢀⣀      u~ u~ na~ na~ una! selamat bermain!'), nl,
    write('⠀⠀⠀⢸⠙⢾⠀⢳⡀'), nl,
    write('⠀⠀⠀⠘⢆⠈⢧⠀⣧'), nl,
    write('⠀⠀⠀⠀⠘⣄⢸⡇⠸⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⡴⢶⣄⠠⠤⠤⠤⠴⢋⣳⠀⠀⠀⠀⠀⠀⠀   ⣰⠏⠈⠳⣄⣀⣀⡤⠖⢢⡀'), nl,
    write('⠀⢀⡴⠒⢉⡽⠀⠀⠀⠤⠤⣌⠙⢶⣄⠀⠀⠀⢀⣠⠟⠊⠀⠀⠀⠀⠀⠀⠀⠐⢦⣄⠀⠀⠀  ⣠⣔⠃⠀⠀⢀⣴⡀   ⠀  ⣷⠀'), nl,
    write('⢠⠟⠀⡴⠁⠀⠀⠀⠀⠀⠀⠈⢷⠀⠹⡆⠀⢠⡟⠀⠀⠀⠔⠂⠀⠀⠈⠁⠀⠀⠀⠘⣧⠀  ⡜⠁⠈⠉⠩⠉⠉⠀⠙⠲⠤⠤⠤⠷⡄'), nl,
    write('⡾⠀⠀⠃⠀⣶⣶⠀⠀⠸⣿⠇⣬⣤⠀⢿⠀⣾⠀⠀⣀⣠⡤⠒⠀⠀⠐⠒⣢⣤⡄⠀⢸⡆⢸⠁⣠⣄⣰⣶⣶⠀⠀⣠⣤⡄⠀   ⢹'), nl,
    write('⢻⠀⠀⡷⠶⠉⠀⠰⢾⡶⠀⠀⠉⠀⠀⡟⠀⢻⡀⠀⢿⡿⠃⠀⢻⣿⠃⠀⠘⠛⠃⠀⡼⠀⠸⡆⠻⠿⠃⠉⠡⣶⣤⠈⠋⣵⣶⠄ ⢸'), nl,
    write('⠈⢳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠁⠀⠈⣳⣄⠀⠀⠀⠀⠈⠉⠀⠀⠀⠀⠀⣴⢧⡄⠀⣹⠆⠀⠀⠀   ⠸⠅⠀⠀    ⣦⠏'), nl,
    write('⠀⠀⣞⢁⡀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣏⡇⠀⠀⠛⠼⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡏⠉⠀⠀⠉⠒⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⢸⠁⠀'), nl,
    write('⠀⠀⠈⠾⢧⡀⠀⠀⠀⠀⠀⠀⢀⡞⠁⠀⠀⠀⠀⠀⠹⣄⠀⠀⠀⣀⠀⠀⠀⣠⠟⠀⠀⠀⠀⠀⠀⢳⣀⠀⠀⠀⠀⠀⠀⠀⣠⡟⣊⡧'), nl,
    write('⠀⠀⠀⠰⣄⡉⡓⠤⣤⢤⣲⡖⠉⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠒⠒⠲⡇⣶⠋⠀⠀⠀⠀⠀⠀⠀⠀⠘⠧⠗⠢⠤⠤⡄⢠⠞⠁⠉⠀⠀'), nl,
    write('⠀⠀    ⠁⠁⠀⠀⠈⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀      ⠈⠉'), nl,
    write('Game disetup!'), nl,
    format('Pemain: ~w~n', [ListPemain]),
    format('Giliran awal: ~w~n', [PemainPertama]),
    nl,
    
    % logic mengacak deck & membagikan kartu
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⢠⠋⠀⠀⠀⠈⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  '), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⢣⡀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⣀⡀⠀⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⢀⠔⠋⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠙⠲⠤⣀⠀⠀⢀⠞⠉⠀⠀⠳⡄⠀⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⢀⠖⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⠼⠀⠀⠀⠀⠀⠀ ⢳⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⡴⠁⠀⠀⠀⠀⠀⠀⠉⠑⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠏⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⡴⠁⠀⠀⠀⠀⠀⠀⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠤⠤⣄⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⢰⠃⠀⠀⠀⠀⠀⠀⠀⠀⢀⣱⡄⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠞⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣧⠀⢨⣷⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⢎⠀⠀⠀⠀⡇⡇⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡋⠉⠙⢿⣿⠇⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⠀⣤⠀⠀⢀⠀⠀⠈⠒⠒⠚⠁⠀⠀⠀⠀⠀ ⡸⠀⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⢟⠒⠋⠘⢲⠚⠁⠀⠀⠀⠀⠀⡆⠇⠇⠀⠀⠀⠀⡜⠀⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠳⠀⠀⠀⠀⠀⠀⠀⠀⠈⠣⠤⠖⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠃⠀⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠴⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠞⠉⠉⠳⡤⠤⣄⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'), nl,
    write(' ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠈⢣⠏⠉⠓⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⠤⢄⡤⡾⠁⠸⠀⢦⢸⠀⡇⡇⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'), nl
    write(' ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⠁⢸⠀⢠⠃⡆⢇⡇⡇⠈⡗⠒⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'), nl,
    write(' ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠁⠀⠀⠉⠁⠀⠃⠀⠃⠈⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'), nl,
    write('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠚⠓⠒⠒⠦⠤⠤⢄⣀⣀⣀⣀⣀⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀'), nl,
    write('Mempersiapkan deck dan membagikan kartu...'), nl,
    inisialisasi_deck(DeckAwal),
    acak_deck(DeckAwal, DeckAcak), 
    
    % bagikan 7 kartu ke masing-masing pemain
    bagi_kartu_pemain(ListPemain, DeckAcak, DeckSisaSetelahBagi),
    
    % tentukan kartu awal di meja (discard_top) -> HARUS KARTU ANGKA
    tentukan_discard_awal(DeckSisaSetelahBagi, KartuAwal, DeckFinal),
    asserta(discard_top(KartuAwal)),
    asserta(deck_kartu(DeckFinal)),
    
    % update warna aktif berdasarkan kartu awal
    KartuAwal = kartu(WarnaAwal, _),
    asserta(warna_aktif(WarnaAwal)),
    
    % --- BAGIAN INI YANG DIPERBAIKI ---
    write('Setiap pemain mendapatkan 7 kartu acak.'), nl,
    format('Kartu discard top: ~w-~w.~n', [WarnaAwal, KartuAwal]),
    format('Giliran ~w.~n', [PemainPertama]).

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

% helper pembuatan deck
valid_kartu(Warna, Jenis) :- warna(Warna), jenis_angka(Jenis).
valid_kartu(Warna, Jenis) :- warna(Warna), jenis_aksi(Jenis).
valid_kartu(hitam, Jenis) :- jenis_aksi_wild(Jenis).

inisialisasi_deck(DeckLengkap) :-
    % findall akan mengumpulkan semua kemungkinan kartu berdasarkan rule valid_kartu
    findall(kartu(W, J), valid_kartu(W, J), DeckDasar),
    % biasanya kartu UNO butuh deck yang banyak, kita bisa gabungkan 2 deck dasar
    append(DeckDasar, DeckDasar, DeckLengkap). 

% helper pembagian kartu
bagi_kartu_pemain([], Deck, Deck). 
bagi_kartu_pemain([Pemain|SisaPemain], DeckSekarang, DeckSisaAkhir) :-
    ambil_N_kartu(7, DeckSekarang, TanganPemain, DeckSisaSementara),
    asserta(tangan_pemain(Pemain, TanganPemain)),
    bagi_kartu_pemain(SisaPemain, DeckSisaSementara, DeckSisaAkhir).

ambil_N_kartu(0, Deck, [], Deck) :- !.
ambil_N_kartu(N, [KartuTop|SisaDeck], [KartuTop|Tangan], DeckAkhir) :-
    N > 0,
    N1 is N - 1,
    ambil_N_kartu(N1, SisaDeck, Tangan, DeckAkhir).

% helper discard awal 
% kartu pertama di discard_top adalah ANGKA (sesuai aturan UNO/UNI)
tentukan_discard_awal([kartu(Warna, Jenis)|SisaDeck], kartu(Warna, Jenis), SisaDeck) :-
    jenis_angka(Jenis), !.

% kartu atas BUKAN angka (misal: reverse, draw_two, wild), pindahkan ke bawah deck, cari lagi
tentukan_discard_awal([KartuAksi|SisaDeck], KartuAwal, DeckSisaAkhir) :-
    \+ jenis_angka(KartuAksi), 
    append(SisaDeck, [KartuAksi], DeckBaru), 
    tentukan_discard_awal(DeckBaru, KartuAwal, DeckSisaAkhir).

% randomize deck
acak_deck(List, Acak) :-
    tambah_kunci_acak(List, ListKunci),
    keysort(ListKunci, ListKunciUrut),
    buang_kunci(ListKunciUrut, Acak).

tambah_kunci_acak([], []).
tambah_kunci_acak([H|T], [K-H|T1]) :-
    random(1, 10000, K),
    tambah_kunci_acak(T, T1).

buang_kunci([], []).
buang_kunci([_-H|T], [H|T1]) :-
    buang_kunci(T, T1).
