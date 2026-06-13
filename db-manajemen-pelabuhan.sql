CREATE DATABASE db_manajemen_pelabuhan;

USE db_manajemen_pelabuhan;

CREATE TABLE pelabuhan (
id_pelabuhan INT PRIMARY KEY AUTO_INCREMENT,
nama_pelabuhan VARCHAR(100) NOT NULL,
kota VARCHAR(50) NOT NULL,
status_dermaga VARCHAR(20) NOT NULL
);

CREATE TABLE kapal (
id_kapal INT PRIMARY KEY,
nama_kapal VARCHAR(50) NOT NULL,
kapasitas_penumpang INT NOT NULL
);

CREATE TABLE petugas (
id_petugas VARCHAR(10) PRIMARY KEY,
nama_petugas VARCHAR(100) NOT NULL,
peran VARCHAR(50) NOT NULL
);

CREATE TABLE penumpang (
id_penumpang INT AUTO_INCREMENT PRIMARY KEY,
nik_penumpang VARCHAR(16) NOT NULL UNIQUE,
nama_penumpang VARCHAR(100) NOT NULL
);

CREATE TABLE rute (
 id_rute VARCHAR(10) PRIMARY KEY,
 id_pelabuhan_asal INT NOT NULL,
 id_pelabuhan_tujuan INT NOT NULL,
 jarak_mil DECIMAL(5,2) NOT NULL,
 FOREIGN KEY (id_pelabuhan_asal) REFERENCES pelabuhan(id_pelabuhan),
 FOREIGN KEY (id_pelabuhan_tujuan) REFERENCES pelabuhan(id_pelabuhan)
);

CREATE TABLE jadwal (
 id_jadwal VARCHAR(10) PRIMARY KEY,
 id_kapal INT NOT NULL,
 id_rute VARCHAR(10) NOT NULL,
 id_petugas VARCHAR(10) NOT NULL,
 waktu_keberangkatan DATETIME NOT NULL,
 FOREIGN KEY (id_kapal) REFERENCES kapal(id_kapal),
 FOREIGN KEY (id_rute) REFERENCES rute(id_rute),
 FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas)
);

CREATE TABLE tiket (
 id_tiket INT AUTO_INCREMENT PRIMARY KEY,
 nomor_tiket VARCHAR(20) NOT NULL UNIQUE,
 id_penumpang INT NOT NULL,
 id_jadwal VARCHAR(10) NOT NULL,
 id_petugas VARCHAR(10) NOT NULL,
 harga_tiket DECIMAL(10,2) NOT NULL,
 FOREIGN KEY (id_penumpang) REFERENCES penumpang(id_penumpang),
 FOREIGN KEY (id_jadwal) REFERENCES jadwal(id_jadwal),
 FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas)
);

INSERT INTO pelabuhan (id_pelabuhan, nama_pelabuhan, kota, status_dermaga) VALUES
(1, 'Sri Bintan Pura', 'Tanjungpinang', 'Aktif'),
(2, 'Telaga Punggur', 'Batam', 'Aktif'),
(3, 'Tanjung Balai Karimun', 'Karimun', 'Aktif');

INSERT INTO kapal (id_kapal, nama_kapal, kapasitas_penumpang) VALUES
(101, 'KMP Barau', 200),
(102, 'MV Oceana', 150),
(103, 'Dumai Express', 120);

INSERT INTO petugas (id_petugas, nama_petugas, peran) VALUES
('P01', 'Fajri', 'Operator Loket'),
('P02', 'Gina', 'Syahbandar'),
('P03', 'Andi', 'Operator Loket');

INSERT INTO penumpang (id_penumpang, nik_penumpang, nama_penumpang) VALUES
(1, '217200000001', 'Iqbal'),
(2, '217200000002', 'Rahmat'),
(3, '217200000003', 'Siti');

INSERT INTO rute (id_rute, id_pelabuhan_asal, id_pelabuhan_tujuan, jarak_mil) VALUES
('R01', 1, 2, 15.50),
('R02', 2, 1, 15.50),
('R03', 3, 2, 32.00);

INSERT INTO jadwal (id_jadwal, id_kapal, id_rute, id_petugas, waktu_keberangkatan) VALUES
('J001', 101, 'R01', 'P02', '2026-06-15 08:00:00'),
('J002', 102, 'R01', 'P02', '2026-06-15 10:30:00'),
('J003', 103, 'R03', 'P02', '2026-06-15 13:00:00');

INSERT INTO tiket (id_tiket, nomor_tiket, id_penumpang, id_jadwal, id_petugas, harga_tiket) VALUES
(1, 'TKT-001', 1, 'J001', 'P01', 60000.00),
(2, 'TKT-002', 2, 'J001', 'P01', 60000.00),
(3, 'TKT-003', 3, 'J003', 'P03', 115000.00);

SELECT nama_pelabuhan, kota FROM pelabuhan WHERE status_dermaga = 'Aktif';

SELECT nama_kapal, kapasitas_penumpang FROM kapal WHERE kapasitas_penumpang > 130;

SELECT id_rute, jarak_mil FROM rute ORDER BY jarak_mil DESC;

SELECT 
    r.id_rute, 
    p1.nama_pelabuhan AS pelabuhan_asal, 
    p2.nama_pelabuhan AS pelabuhan_tujuan, 
    r.jarak_mil
FROM rute r
JOIN pelabuhan p1 ON r.id_pelabuhan_asal = p1.id_pelabuhan
JOIN pelabuhan p2 ON r.id_pelabuhan_tujuan = p2.id_pelabuhan;

SELECT 
    t.nomor_tiket, 
    p.nama_penumpang, 
    t.id_jadwal
FROM tiket t
JOIN penumpang p ON t.id_penumpang = p.id_penumpang
WHERE t.id_jadwal = 'J001';

SELECT 
    t.nomor_tiket, 
    p.nama_penumpang, 
    k.nama_kapal, 
    pt.nama_petugas AS melayani_di_loket,
    t.harga_tiket
FROM tiket t
JOIN penumpang p ON t.id_penumpang = p.id_penumpang
JOIN jadwal j ON t.id_jadwal = j.id_jadwal
JOIN kapal k ON j.id_kapal = k.id_kapal
JOIN petugas pt ON t.id_petugas = pt.id_petugas;

SELECT SUM(harga_tiket) AS total_pendapatan FROM tiket;

SELECT id_petugas, COUNT(id_tiket) AS jumlah_tiket_terjual 
FROM tiket 
GROUP BY id_petugas;SELECT id_petugas, COUNT(id_tiket) AS jumlah_tiket_terjual 
FROM tiket 
GROUP BY id_petugas;

UPDATE pelabuhan 
SET status_dermaga = 'Uji Coba' 
WHERE id_pelabuhan = 3;

DELETE FROM tiket 
WHERE nomor_tiket = 'TKT-002';