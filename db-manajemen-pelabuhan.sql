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