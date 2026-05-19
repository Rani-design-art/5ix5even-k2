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
    nl, write('                  .=**-.=%%*:    -=*+.:==.'), nl,
    write('                   @+::=@#::=%.  *%::-#@--%='), nl,
    write('                  .@*:::::::+#.  *%:::::::%#'), nl,
    write('                   :@%=-::=%+    :%%-:::-##'), nl,
    write('                     :*@@@%:       -#%#%#:'), nl,
    write('                       #+           :#-'), nl,
    write('                      :@%#+.        +#-:'), nl,
    write('             .--:.    .%#*#        +@#*# .-+++-.'), nl,
    write('           .##=:-#%+  :%:          #+.. +%-..-#@+'), nl,
    write('           @*     =@=-%@@@@@@@@@@@@@%+.:%-     =%:        Game berhasil disetup!'), nl,
    write('           %=     =%*=.             .=*#%=     -%:           Selamat bermain~'), nl,
    write('            =#:                                =%-'), nl,
    write('          *%#-                                :*'), nl,
    write('        =@#                                    .#@:                  ..'), nl,
    write('      :%%:                                       .*@*               .:=#+'), nl,
    write('    .*@+            -##*+:           =#%#*+        :%%.            :+#+ +='), nl,
    write('    +@-                                             :#@.              *#'), nl,
    write('   #@-               ...               ..            .%@:  *@%%%@*'), nl,
    write('  +@-             =@%=:*%-          -%%++%%-          =@*-@*::::=@+===-:'), nl,
    write(' -@#             -@@#==#@%.        .%@*.  #%.          %@@*:::::-%#-:-*@+'), nl,
    write(' +@:         .....%%=@%@@*         .%@*@@%@%           *@@-::::::::::::=%:'), nl,
    write(' *%.      .%*-%+--:-*%%%=           :#%#@@#:=+:=--:    -@@+::::::::::::=%-'), nl,
    write('.#%      .#=-#==%-##          +@-      .:..+#-%#=%*%.  :@@@-::::::::::=@+'), nl,
    write('.#%.      ..:::=::-.       %#*@@=--       .=:=+:==%-   :@=*@-:::::::+%@*'), nl,
    write(' +@.                            ..          ......     *@- @@+++#%@@#:'), nl,
    write('  *@:                                                 *%=%=.%+'), nl,
    write('   #%-                                               +@-@=:@*'), nl,
    write('    :%#.                                           .*@@@==@-'), nl,
    write('     .+@#:                                        =@*:##*%-'), nl,
    write('       :%-                                       .-.  -#+'), nl,
    write('       =%: :%-                                      *@:'), nl,
    write('       +%: :%-                                   .##:'), nl,
    write('       .#*+%*.                                   +@'), nl,
    write('         ..=%:                                  -@-'), nl,
    write('          *@@@=                                -@='), nl,
    write('         :#  -@#.                            .#%:'), nl,
    write('          =*#**+%#:                        :*%='), nl,
    write('                 -#@*:                  =#%*:'), nl,
    write('                    .=*%%+  .+.  -+**%%#-'), nl,
    write('                        :%= :%*  *%'), nl,
    write('                         +%..#* =@:'), nl,
    write('                          .===*@+'), nl,
    format('Pemain: ~w~n', [ListPemain]),
    format('Giliran awal: ~w~n', [PemainPertama]),
    nl,
    
    % logic mengacak deck & membagikan kartu
    write('                                                                                                    '), nl,
    write('                                                                                                    '), nl,
    write('                                                                                                    '), nl,
    write('                                                                                                    '), nl,
    write('                                                                                                    '), nl,
    write('                                *@@@@@@@@@@@@#-                                                     '), nl,
    write('                           +@@@@@@@@@@@@@@@@@@@@@@@:                                                '), nl,
    write('                        @@@@@@@@@@*+-==+@@@@@@@@@@@@@@-                                             '), nl,
    write('                     %@@@@@@@@@@@    .:=+*:     =@@@@@@@@                                           '), nl,
    write('                   @@@@@@@@@@@@@:     ..:=+#        @@@@@@@-                                        '), nl,
    write('                 *@@@@@@@-..:-=:.        ..=* =@@@@@@@@@@@@@                                     '), nl,
    write('                @@@@@@@%   . ::-=-.       .::-:-+%#%@@@@@@@@@@@@@                                   '), nl,
    write('               @@@@@@@@       .:--==.    .......:==-**%@@@@@@@@@@@#                                 '), nl,
    write('              @@@@@@@            :--=+........:..--=+=*%@@@@@@@@@@@@                                '), nl,
    write('              @@@@@#             .:-  . . .: .: ::::-=***%@@@@@@@@@@@                               '), nl,
    write('             -@@@@:                        .... ... -+#@@=*@@@@@@@@@@                               '), nl,
    write('             +@@@@                         . .:::..::=-@@@++*@@@@@@@@+                              '), nl,
    write('             +@@@%            .              .::..:::--+-=*#%%@@@@@@*=+=                            '), nl,
    write('             :@@@@         *-  =.              :::---#::=-=+#%@@@@@-:.:+=+                          '), nl,
    write('              @@@@        @@@@@@%-        .:    .:=@@@@ .-++#%@@@@-.  .:-++                         '), nl,
    write('               @@@=     -@@@@@@@@@*.      +@@@   :-+@*:-=+=**%@@%=..   .:=+.                        '), nl,
    write('               :@@@@    @@@@@@@@@@@@-     .*@@   .::--::*+==#*+*++-..:.::-* '), nl,
    write('                 @@@@@@@@@@@@@@@@@@@@*.    . .   .::--:+++--:====*+++:-=+*.                         '), nl,
    write('                   #@@@@@@@@@@@@@@@@@@@-.        ..:.:=---:------=+++**%+                           '), nl,
    write('                    .@@@@@@@@@@@@@@@@@@@#:   .    ..:....::=:::--=====**:                           '), nl,
    write('                       #@@@@@@@@@@@@@@@@@@=.          .: :::.:::::--:--=+:.::--=*=                  '), nl,
    write('                        :@@@@@%@@@@@@@@@@@@#:           ..:::..:.:-::.:..:.  .:==+* '), nl,
    write('                          %*@@@@@@@@@@@@@@@@%=          . ..:.:...::....     ...:-+#                '), nl,
    write('                           -%@@@@@@@@@@@@@@@*.              :.::..:.         .:::--+-               '), nl,
    write('                             *@@@@@@@@@@@@@+:.           .:. ::=.:::.      ..::::-=* '), nl,
    write('                               #@@@@@@@#-:=+-+:         . .:::--:-:::    . ...::-=#                 '), nl,
    write('                                  %##.--==-=++=          ...:---=---:.     .:..:-+.                 '), nl,
    write('                                     :.::---+++.      .:.::-==+++++===-..:..::---                   '), nl,
    write('                                        :=+==-=        .:--=*#%%@%%%%* '), nl,
    write('                                       ..:=+==:       .:-====+*#@@%#                                '), nl,
    write('                                        .:=-           .:-=++=+*##                                  '), nl,
    write('                                                     ..::===++*#* '), nl,
    write('                                                        ..=+-++*+                                   '), nl,
    write('                                                        ..-==*++#                                   '), nl,
    write('                                                       . :-=-+*++                                   '), nl,
    write('                                                        ::-=++==                                    '), nl,
    write('                                                       ::.:-=:-                                     '), nl,
    write('                                                                                                    '), nl,
    write('                                                                                                    '), nl,
    write('                                                                                                    '), nl,
    write('                                                                                                    '), nl,
    write('                                                                                                    '), nl,
    write('                                                                                                    '), nl,
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
acak_deck([], []).
% Rekursi: Cabut 1 kartu acak, lalu acak sisanya
acak_deck(ListAwal, [KartuAcak|SisaAcak]) :-
    random_card(ListAwal, KartuAcak, ListSisa),
    acak_deck(ListSisa, SisaAcak).

random_card(List, Card, NewList) :-
    count_list(List, Len),
    random(0, Len, Index),
    pick_at_index(List, Index, Card, NewList).

count_list([], 0).
count_list([_|T], N) :-
    count_list(T, N1),
    N is N1 + 1.

pick_at_index([H|T], 0, H, T) :- !.
pick_at_index([H|T], I, Card, [H|Rest]) :-
    I > 0,
    I1 is I - 1,
    pick_at_index(T, I1, Card, Rest).

% fitur endGame & perhitungan poin


% aturan nilai poin kartu
poin_kartu(kartu(_, Jenis), Poin) :-
    jenis_angka(Jenis), Poin is Jenis, !.
poin_kartu(kartu(_, Jenis), 10) :-
    jenis_aksi(Jenis), !.
poin_kartu(kartu(hitam, Jenis), 20) :-
    jenis_aksi_wild(Jenis), !.

% ngitung total poin dari list kartu di tangan
hitung_poin_tangan([], 0).
hitung_poin_tangan([Kartu|Sisa], TotalPoin) :-
    poin_kartu(Kartu, Poin),
    hitung_poin_tangan(Sisa, PoinSisa),
    TotalPoin is Poin + PoinSisa.

% ngecek apakah permainan sudah selesai (kartunya kosong)
cek_selesai :-
    (   tangan_pemain(_, [])
    ->  endGame
    ;   true
    ).

% spek endGame
endGame :-
    tangan_pemain(Pemenang, []), !,
    format('Permainan selesai! ~w menghabiskan semua kartunya!~n~n', [Pemenang]),
    write('Berikut perhitungan poin sisa kartu.'), nl,
    
    % nyetak perhitungan poin tiap pemain
    urutan_pemain(UrutanAsli),
    cetak_semua_rincian(UrutanAsli),
    nl,
    
    write('Urutan pemenang:'), nl,
    kumpulkan_skor(UrutanAsli, UrutanAsli, ListSkor),
    sort(ListSkor, ListSkorSorted), 
    cetak_urutan_pemenang(ListSkorSorted, 1),
    nl,
    format('Selamat, ~w menjadi pemenang!~n', [Pemenang]),
    !.

endGame :-
    write('Belum ada pemain yang menghabiskan kartu. Lanjut main!'), nl.

% helper pencetakan rincian poin
cetak_semua_rincian([]).
cetak_semua_rincian([Pemain|T]) :-
    cetak_rincian_poin(Pemain),
    cetak_semua_rincian(T).

cetak_rincian_poin(Pemain) :-
    tangan_pemain(Pemain, Tangan),
    (   Tangan == []
    ->  format('~w: kartu habis = 0 poin~n', [Pemain])
    ;   format('~w: ', [Pemain]),
        cetak_kartu_rincian(Tangan),
        write(' = '),
        cetak_angka_rincian(Tangan),
        hitung_poin_tangan(Tangan, Total),
        format(' = ~w poin~n', [Total])
    ).

cetak_kartu_rincian([kartu(Warna, Jenis)]) :- format('~w-~w', [Warna, Jenis]), !.
cetak_kartu_rincian([kartu(Warna, Jenis)|T]) :- 
    format('~w-~w + ', [Warna, Jenis]), 
    cetak_kartu_rincian(T).

cetak_angka_rincian([Kartu]) :- poin_kartu(Kartu, Poin), write(Poin), !.
cetak_angka_rincian([Kartu|T]) :- 
    poin_kartu(Kartu, Poin), 
    format('~w + ', [Poin]), 
    cetak_angka_rincian(T).

% helper mengumpulkan data dan peringkat
% List output format: skor(TotalPoin, JmlKartu, IndexUrutanAwal, NamaPemain)
kumpulkan_skor([], _, []).
kumpulkan_skor([Pemain|T], UrutanAsli, [skor(Poin, JmlKartu, Index, Pemain)|SisaSkor]) :-
    tangan_pemain(Pemain, Tangan),
    hitung_poin_tangan(Tangan, Poin),
    length(Tangan, JmlKartu),
    nth0(Index, UrutanAsli, Pemain), % Index dipakai untuk tie-breaker ke-2
    kumpulkan_skor(T, UrutanAsli, SisaSkor).

cetak_urutan_pemenang([], _).
cetak_urutan_pemenang([skor(Poin, _, _, Pemain)|T], Peringkat) :-
    format('~w. ~w (~w poin)~n', [Peringkat, Pemain, Poin]),
    Peringkat1 is Peringkat + 1,
    cetak_urutan_pemenang(T, Peringkat1).
