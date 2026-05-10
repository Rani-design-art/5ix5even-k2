:- dynamic(giliran_sekarang/1).
:- dynamic(tangan_pemain/2).
:- dynamic(discard_top/1).
:- dynamic(warna_aktif/1).
:- dynamic(sisa_kartu/1).
:- dynamic(efek_kartu/1).
:- dynamic(deck_kartu/1).
:- dynamic(urutan_pemain/1).
:- dynamic(kartu_disembunyikan/2).

/* Facts */
warna(merah). warna(kuning). warna(hijau). warna(biru).
warna_wild(hitam).

jenis_angka(0). jenis_angka(1). jenis_angka(2). jenis_angka(3). jenis_angka(4).
jenis_angka(5). jenis_angka(6). jenis_angka(7). jenis_angka(8). jenis_angka(9).
jenis_aksi(skip). jenis_aksi(reverse). jenis_aksi(draw_two).
jenis_aksi_wild(wild). jenis_aksi_wild(wild_draw_four).

/* Rules */
valid_dimainkan(kartu(hitam, wild), _, _).
valid_dimainkan(kartu(hitam, wild_draw_four), _, _).
valid_dimainkan(kartu(Warna, _), _, Warna).
valid_dimainkan(kartu(_, Jenis), kartu(_, Jenis), _).

ambil_kartu(1, [H|_], H).
ambil_kartu(N, [_|T], KartuPilihan) :-
    N > 1,
    N1 is N - 1,
    ambil_kartu(N1, T, KartuPilihan).

hapus_kartu_ke(1, [_|T], T) :- !.
hapus_kartu_ke(N, [H|T], [H|R]) :-
    N > 1,
    N1 is N - 1,
    hapus_kartu_ke(N1, T, R).

/* Helper MAINKAN KARTU*/
input_lagi :-
    write('Tidak valid! Masukkan nomor urut kartu lain (atau ketik batal. untuk batal): '),
    read(Masukan),
    (   Masukan == batal
    ->  write('Batal memainkan kartu. Silakan lakukan aksi lain! (misal: ambilKartu).'), nl
    ;   mainkanKartu(Masukan)
    ).

update_warna_aktif(hitam) :- !,
    write('Pilih warna (merah/kuning/hijau/biru): '),
    read(WarnaBaru),
    (   member(WarnaBaru, [merah, kuning, hijau, biru])
    ->  retract(warna_aktif(_)),
        asserta(warna_aktif(WarnaBaru)),
        format('Warna aktif sekarang: ~w.~n', [WarnaBaru])
    ;   write('Warna tidak valid! Coba lagi.'), nl,
        update_warna_aktif(hitam)
    ).

update_warna_aktif(Warna) :-
    Warna \= hitam,
    retract(warna_aktif(_)),
    asserta(warna_aktif(Warna)).

aplikasikan_efek(kartu(_, Jenis)) :-
    (jenis_angka(Jenis) ; Jenis == wild),
    !,
    pindah_giliran.

/* MAINKAN KARTU */
mainkanKartu(NomorUrutKartudiTangan) :-
    giliran_sekarang(Pemain),
    tangan_pemain(Pemain, ListKartu),
    (   ambil_kartu(NomorUrutKartudiTangan, ListKartu, KartuPilihan)
    ->  discard_top(KartuAtas),
        warna_aktif(WarnaAktif),
        (   valid_dimainkan(KartuPilihan, KartuAtas, WarnaAktif)
        ->  KartuPilihan = kartu(WarnaKartu, JenisKartu),
            format('~w memainkan kartu: ~w-~w.~n', [Pemain, WarnaKartu, JenisKartu]),

            hapus_kartu_ke(NomorUrutKartudiTangan, ListKartu, ListKartuBaru),
            retract(tangan_pemain(Pemain, _)),
            asserta(tangan_pemain(Pemain, ListKartuBaru)),
            
            retract(discard_top(_)),
            asserta(discard_top(KartuPilihan)),
            
            update_warna_aktif(WarnaKartu),
            aplikasikan_efek(KartuPilihan)
        ;   write('Kartu tidak valid! Warna atau jenisnya tidak sesuai.'), nl,
            input_lagi
        )   ;   write('Nomor urut tidak valid! Anda tidak memiliki kartu di posisi tersebut.'), nl,
        input_lagi
    ).

/* AMBIL KARTU */
ambilKartu :-
    giliran_sekarang(Pemain),
    efek_kartu(Eff),
    (Eff == draw2 -> N = 2;
     Eff == draw4 -> N = 4;
     N = 1),
    proses_ambil(Pemain, N),
    retract(efek_kartu(_)),
    asserta(efek_kartu(none)),
    format('~w mendapatkan kartu.~n', [Pemain]),
    pindah_giliran.

proses_ambil(_,0) :- !.
proses_ambil(Pemain, N) :-
    retract(deck_kartu([H|T])),
    retract(tangan_pemain(Pemain, Tangan)),
    append(Tangan, [H], Tangan1),
    asserta(tangan_pemain(Pemain, Tangan1)),
    asserta(deck_kartu(T)),
    N1 is N - 1,
    proses_ambil(Pemain, N1).

pindah_giliran :-
    retract(giliran_sekarang(Pemain)),
    urutan_pemain(Urutan),
    pemain_selanjutnya(Pemain, Urutan, Pemain1),
    asserta(giliran_sekarang(Pemain1)),
    format('Giliran ~w.~n', [Pemain1]).

pemain_selanjutnya(Sebelum, List, Sesudah) :- 
    nth0(Indeks, List, Sebelum),
    length(List, Len),
    Indeks1 is (Indeks + 1) mod Len,
    nth0(Indeks1, List, Sesudah).

/* LIHAT COMMAND */
lihatCommand :-
    efek_kartu(Eff),
    write('Aksi utama yang tersedia:'), nl,
    tampilkan_aksi_utama(Eff),
    nl,
    write('Aksi pendukung yang tersedia:'), nl,
    write('1. lihatCommand'), nl,
    write('2. lihatKartu'), nl,
    write('3. cekInfo'), nl.
 
tampilkan_aksi_utama(draw_two) :- !,
    write('1. ambilKartu'), nl.
 
tampilkan_aksi_utama(draw_four) :- !,
    write('1. ambilKartu'), nl,
    write('2. tantang'), nl.
 
tampilkan_aksi_utama(_) :-
    write('1. mainkanKartu(NomorUrut)'), nl,
    write('2. ambilKartu'), nl,
    write('3. tantang'), nl,
    write('4. uni(NomorUrut)'), nl,
    write('5. godsHand'), nl,
    write('6. sembunyikanKartu(NomorUrut)'), nl,
    write('7. tampilkanKartu'), nl.
 
/* LIHAT KARTU */
:- dynamic(kartu_disembunyikan/2).
 
lihatKartu :-
    giliran_sekarang(Pemain),
    tangan_pemain(Pemain, ListKartu),
    write('Berikut kartu yang anda miliki.'), nl,
    tampilkan_list_kartu(ListKartu, Pemain, 1).
 
tampilkan_list_kartu([], _, _) :- !.
 
tampilkan_list_kartu([kartu(Warna, Jenis) | Sisa], Pemain, N) :-
    (   kartu_disembunyikan(Pemain, N)
    ->  format('~w. ~w-~w (disembunyikan)~n', [N, Warna, Jenis])
    ;   format('~w. ~w-~w~n', [N, Warna, Jenis])
    ),
    N1 is N + 1,
    tampilkan_list_kartu(Sisa, Pemain, N1).
 
 
/* CEK INFO */
 
cekInfo :-
    discard_top(kartu(Warna, Jenis)),
    format('Kartu discard top: ~w-~w.', [Warna, Jenis]), nl,
    nl,
 
    urutan_pemain(ListPemain),
    write('Urutan pemain: '),
    cetak_urutan_pemain(ListPemain), nl,
    nl,
 
    cetak_info_semua_pemain(ListPemain, 1).
 
cetak_urutan_pemain([]).
cetak_urutan_pemain([P]) :- !, write(P), write('.').
cetak_urutan_pemain([P|Sisa]) :-
    write(P), write(' - '),
    cetak_urutan_pemain(Sisa).
 
cetak_info_semua_pemain([], _) :- !.
cetak_info_semua_pemain([Pemain|Sisa], N) :-
    tangan_pemain(Pemain, ListKartu),
    length(ListKartu, JumlahKartu),
    format('Nama pemain ~w: ~w~n', [N, Pemain]),
    format('Jumlah kartu : ~w~n', [JumlahKartu]),
    nl,
    N1 is N + 1,
    cetak_info_semua_pemain(Sisa, N1).
