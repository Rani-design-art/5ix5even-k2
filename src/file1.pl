:- dynamic giliran_sekarang/1.
:- dynamic tangan_pemain/2.
:- dynamic discard_top/1.
:- dynamic warna_aktif/1.

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
    write('Masukkan nomor urut kartu lain: '),
    read(NomorBaru),
    mainkanKartu(NomorBaru).

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

pindah_giliran :- 
    write('Giliran berikutnya...'), nl.

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
