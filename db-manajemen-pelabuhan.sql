USE db_manajemen_pelabuhan;

CREATE TABLE pelabuhan (
    id_pelabuhan INT PRIMARY KEY AUTO_INCREMENT,
    nama_pelabuhan VARCHAR(100) NOT NULL,
    kota VARCHAR(50) NOT NULL,
    status_dermaga VARCHAR(20) NOT NULL
);

