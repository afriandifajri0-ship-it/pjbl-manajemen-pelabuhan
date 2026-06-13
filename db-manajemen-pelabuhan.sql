
Setting environment for using XAMPP for Windows.
ASUS@LAPTOP-VJRH4MEH c:\xampp
# mysql -u root
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 10
Server version: 10.4.32-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> USE rental_mobil;
Database changed
MariaDB [rental_mobil]> ALTER TABLE mobil ADD COLUMN jumlah_mobil INT DEFAULT 25;
Query OK, 0 rows affected (0.012 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [rental_mobil]> SELECT * FROM mobil;
+----------+------------+-------------+-----------+-------+--------------+
| id_mobil | no_polisi  | tipe        | warna     | tahun | jumlah_mobil |
+----------+------------+-------------+-----------+-------+--------------+
|        1 | BP 1234 AB | Sedan       | Hitam     |  2020 |           25 |
|        2 | BP 5678 CD | SUV         | Putih     |  2017 |           25 |
|        3 | BP 9012 EF | Hatchback   | Merah     |  2019 |           25 |
|        4 | BP 3456 GH | MPV         | Biru      |  2021 |           25 |
|        5 | BP 7890 IJ | Coupe       | Abu-abu   |  2025 |           25 |
|        6 | BP 2345 KL | Convertible | Kuning    |  2020 |           25 |
|        7 | BP 6789 MN | Van         | Hijau     |  2012 |           25 |
|        8 | BP 0123 OP | Pickup      | Coklat    |  2011 |           25 |
|        9 | BP 4567 QR | Wagon       | Ungu      |  2002 |           25 |
|       10 | BP 8901 ST | Roadster    | Pink      |  2023 |           25 |
|       11 | BP 3456 UV | Minivan     | Perak     |  2005 |           25 |
|       12 | BP 7890 WX | Crossover   | Emas      |  2015 |           25 |
|       13 | BP 2345 YZ | Limousine   | Biru Muda |  2010 |           25 |
+----------+------------+-------------+-----------+-------+--------------+
13 rows in set (0.001 sec)

MariaDB [rental_mobil]> CREATE TABLE ketersediaan_mobil (
    -> id INT AUTO_INCREMENT PRIMARY KEY,
    -> tipe VARCHAR(50),
    -> mobil_tersedia INT,
    -> mobil_disewa INT
    -> );
Query OK, 0 rows affected (0.076 sec)

MariaDB [rental_mobil]> SELECT * FROM ketersediaan_mobil;
Empty set (0.023 sec)

MariaDB [rental_mobil]> DELIMITER //
MariaDB [rental_mobil]> CREATE TRIGGER trg_ketersediaan_mobil
    -> AFTER INSERT ON sewa_mobil
    -> FOR EACH ROW
    -> BEGIN
    -> UPDATE ketersediaan_mobil
    -> SET mobil_tersedia = mobil_tersedia - 1,
    -> mobil_disewa = mobil_disewa + 1
    -> WHERE tipe = (SELECT tipe FROM mobil WHERE id_mobil = NEW.id_mobil);
    -> END// DELIMITER ;
Query OK, 0 rows affected (0.029 sec)

    -> //
MariaDB [rental_mobil]> DROP TRIGGER IF EXISTS trg_ketersediaan_mobil;
Query OK, 0 rows affected (0.016 sec)

MariaDB [rental_mobil]> CREATE TRIGGER trg_ketersediaan_mobil
    -> AFTER INSERT ON sewa_mobil
    -> FOR EACH ROW
    -> BEGIN
    -> UPDATE ketersediaan_mobil
    -> SET mobil_tersedia = mobil_tersedia - 1,
    -> mobil_disewa = mobil_disewa + 1
    -> WHERE tipe = (SELECT tipe FROM mobil WHERE id_mobil = NEW.id_mobil);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '' at line 8
MariaDB [rental_mobil]> CREATE TRIGGER trg_ketersediaan_mobil
    -> AFTER INSERT ON sewa_mobil
    -> FOR EACH ROW
    -> UPDATE ketersediaan_mobil
    -> SET mobil_tersedia = mobil_tersedia - 1,
    -> mobil_disewa = mobil_disewa + 1
    -> WHERE tipe = (SELECT tipe FROM mobil WHERE id_mobil = NEW.id_mobil);
Query OK, 0 rows affected (0.010 sec)

MariaDB [rental_mobil]> DESC sewa_mobil;
+-----------------+--------------+------+-----+---------+----------------+
| Field           | Type         | Null | Key | Default | Extra          |
+-----------------+--------------+------+-----+---------+----------------+
| id_sewa_mobil   | int(11)      | NO   | PRI | NULL    | auto_increment |
| id_admin        | int(11)      | NO   | MUL | NULL    |                |
| id_tarif_mobil  | int(11)      | NO   | MUL | NULL    |                |
| id_mobil        | int(11)      | NO   |     | NULL    |                |
| tanggal_sewa    | date         | NO   |     | NULL    |                |
| tanggal_kembali | date         | YES  |     | NULL    |                |
| no_identitas    | varchar(50)  | NO   |     | NULL    |                |
| nama            | varchar(100) | NO   |     | NULL    |                |
| Alamat          | text         | YES  |     | NULL    |                |
| no_hp           | varchar(20)  | YES  |     | NULL    |                |
| email           | varchar(100) | YES  |     | NULL    |                |
| lokasi          | varchar(255) | YES  |     | NULL    |                |
+-----------------+--------------+------+-----+---------+----------------+
12 rows in set (0.045 sec)

MariaDB [rental_mobil]> INSERT INTO sewa_mobil (
    -> id_admin, id_tarif_mobil, id_mobil,
    -> tanggal_sewa, tanggal_kembali, no_identitas,
    -> nama, alamat, no_hp, email, lokasi)
    -> VALUES
    -> (1, 1, 1, NOW(), '2026-06-15', '2172032407060001', 'Fajri', 'Tanjungpinang', '082267276921', 'Fajri@gmail.com', 'Parawisata');
Query OK, 1 row affected, 1 warning (0.028 sec)

MariaDB [rental_mobil]> SELECT * FROM ketersediaan_mobil WHERE id_mobil = 1;
ERROR 1054 (42S22): Unknown column 'id_mobil' in 'where clause'
MariaDB [rental_mobil]> SELECT * FROM ketersediaan_mobil;
Empty set (0.001 sec)

MariaDB [rental_mobil]> Bye

ASUS@LAPTOP-VJRH4MEH c:\xampp
# mysql - u root
mysql  Ver 15.1 Distrib 10.4.32-MariaDB, for Win64 (AMD64), source revision c4143f909528e3fab0677a28631d10389354c491
Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Usage: mysql [OPTIONS] [database]

Default options are read from the following files in the given order:
C:\Windows\my.ini C:\Windows\my.cnf C:\my.ini C:\my.cnf C:\xampp\mysql\my.ini C:\xampp\mysql\my.cnf C:\xampp\mysql\data\my.ini C:\xampp\mysql\data\my.cnf C:\xampp\mysql\bin\my.ini C:\xampp\mysql\bin\my.cnf
The following groups are read: mysql mariadb-client client client-server client-mariadb
The following options may be given as the first argument:
--print-defaults          Print the program argument list and exit.
--no-defaults             Don't read default options from any option file.
The following specify which files/extra groups are read (specified before remaining options):
--defaults-file=#         Only read default options from the given file #.
--defaults-extra-file=#   Read this file after the global files are read.
--defaults-group-suffix=# Additionally read default groups with # appended as a suffix.

  -?, --help          Display this help and exit.
  -I, --help          Synonym for -?
  --abort-source-on-error
                      Abort 'source filename' operations in case of errors
  --auto-rehash       Enable automatic rehashing. One doesn't need to use
                      'rehash' to get table and field completion, but startup
                      and reconnecting may take a longer time. Disable with
                      --disable-auto-rehash.
                      (Defaults to on; use --skip-auto-rehash to disable.)
  -A, --no-auto-rehash
                      No automatic rehashing. One has to use 'rehash' to get
                      table and field completion. This gives a quicker start of
                      mysql and disables rehashing on reconnect.
  --auto-vertical-output
                      Automatically switch to vertical output mode if the
                      result is wider than the terminal width.
  -B, --batch         Don't use history file. Disable interactive behavior.
                      (Enables --silent.)
  --binary-as-hex     Print binary data as hex
  --character-sets-dir=name
                      Directory for character set files.
  --column-type-info  Display column type information.
  -c, --comments      Preserve comments. Send comments to the server. The
                      default is --skip-comments (discard comments), enable
                      with --comments.
  -C, --compress      Use compression in server/client protocol.
  -#, --debug[=#]     This is a non-debug version. Catch this and exit.
  --debug-check       Check memory and open file usage at exit.
  -T, --debug-info    Print some debug info at exit.
  -D, --database=name Database to use.
  --default-character-set=name
                      Set the default character set.
  --delimiter=name    Delimiter to be used.
  -e, --execute=name  Execute command and quit. (Disables --force and history
                      file.)
  --enable-cleartext-plugin
                      Obsolete option. Exists only for MySQL compatibility.
  -E, --vertical      Print the output of a query (rows) vertically.
  -f, --force         Continue even if we get an SQL error. Sets
                      abort-source-on-error to 0
  -G, --named-commands
                      Enable named commands. Named commands mean this program's
                      internal commands; see mysql> help . When enabled, the
                      named commands can be used from any line of the query,
                      otherwise only from the first line, before an enter.
                      Disable with --disable-named-commands. This option is
                      disabled by default.
  -i, --ignore-spaces Ignore space after function names.
  --init-command=name SQL Command to execute when connecting to MariaDB server.
                      Will automatically be re-executed when reconnecting.
  --local-infile      Enable/disable LOAD DATA LOCAL INFILE.
  -b, --no-beep       Turn off beep on error.
  -h, --host=name     Connect to host.
  -H, --html          Produce HTML output.
  -X, --xml           Produce XML output.
  --line-numbers      Write line numbers for errors.
                      (Defaults to on; use --skip-line-numbers to disable.)
  -L, --skip-line-numbers
                      Don't write line number for errors.
  -n, --unbuffered    Flush buffer after each query.
  --column-names      Write column names in results.
                      (Defaults to on; use --skip-column-names to disable.)
  -N, --skip-column-names
                      Don't write column names in results.
  --sigint-ignore     Ignore SIGINT (CTRL-C).
  -o, --one-database  Ignore statements except those that occur while the
                      default database is the one named at the command line.
  --pager[=name]      Pager to use to display results. If you don't supply an
                      option, the default pager is taken from your ENV variable
                      PAGER. Valid pagers are less, more, cat [> filename],
                      etc. See interactive help (\h) also. This option does not
                      work in batch mode. Disable with --disable-pager. This
                      option is disabled by default.
  -p, --password[=name]
                      Password to use when connecting to server. If password is
                      not given it's asked from the tty.
  -W, --pipe          Use named pipes to connect to server.
  -P, --port=#        Port number to use for connection or 0 for default to, in
                      order of preference, my.cnf, $MYSQL_TCP_PORT,
                      /etc/services, built-in default (3306).
  --progress-reports  Get progress reports for long running commands (like
                      ALTER TABLE)
                      (Defaults to on; use --skip-progress-reports to disable.)
  --prompt=name       Set the command line prompt to this value.
  --protocol=name     The protocol to use for connection (tcp, socket, pipe).
  -q, --quick         Don't cache result, print it row by row. This may slow
                      down the server if the output is suspended. Doesn't use
                      history file.
  -r, --raw           Write fields without conversion. Used with --batch.
  --reconnect         Reconnect if the connection is lost. Disable with
                      --disable-reconnect. This option is enabled by default.
                      (Defaults to on; use --skip-reconnect to disable.)
  -s, --silent        Be more silent. Print results with a tab as separator,
                      each row on new line.
  -S, --socket=name   The socket file to use for connection.
  --ssl               Enable SSL for connection (automatically enabled with
                      other flags).
  --ssl-ca=name       CA file in PEM format (check OpenSSL docs, implies
                      --ssl).
  --ssl-capath=name   CA directory (check OpenSSL docs, implies --ssl).
  --ssl-cert=name     X509 cert in PEM format (implies --ssl).
  --ssl-cipher=name   SSL cipher to use (implies --ssl).
  --ssl-key=name      X509 key in PEM format (implies --ssl).
  --ssl-crl=name      Certificate revocation list (implies --ssl).
  --ssl-crlpath=name  Certificate revocation list path (implies --ssl).
  --tls-version=name  TLS protocol version for secure connection.
  --ssl-verify-server-cert
                      Verify server's "Common Name" in its cert against
                      hostname used when connecting. This option is disabled by
                      default.
  -t, --table         Output in table format.
  --tee=name          Append everything into outfile. See interactive help (\h)
                      also. Does not work in batch mode. Disable with
                      --disable-tee. This option is disabled by default.
  -u, --user=name     User for login if not current user.
  -U, --safe-updates  Only allow UPDATE and DELETE that uses keys.
  -U, --i-am-a-dummy  Synonym for option --safe-updates, -U.
  -v, --verbose       Write more. (-v -v -v gives the table output format).
  -V, --version       Output version information and exit.
  -w, --wait          Wait and retry if connection is down.
  --connect-timeout=# Number of seconds before connection timeout.
  --max-allowed-packet=#
                      The maximum packet length to send to or receive from
                      server.
  --net-buffer-length=#
                      The buffer size for TCP/IP and socket communication.
  --select-limit=#    Automatic limit for SELECT when using --safe-updates.
  --max-join-size=#   Automatic limit for rows in a join when using
                      --safe-updates.
  --secure-auth       Refuse client connecting to server if it uses old
                      (pre-4.1.1) protocol.
  --server-arg=name   Send embedded server this as a parameter.
  --show-warnings     Show warnings after every statement.
  --plugin-dir=name   Directory for client-side plugins.
  --default-auth=name Default authentication client-side plugin to use.
  --binary-mode       Binary mode allows certain character sequences to be
                      processed as data that would otherwise be treated with a
                      special meaning by the parser. Specifically, this switch
                      turns off parsing of all client commands except \C and
                      DELIMITER in non-interactive mode (i.e., when binary mode
                      is combined with either 1) piped input, 2) the --batch
                      mysql option, or 3) the 'source' command). Also, in
                      binary mode, occurrences of '\r\n' and ASCII '\0' are
                      preserved within strings, whereas by default, '\r\n' is
                      translated to '\n' and '\0' is disallowed in user input.
  --connect-expired-password
                      Notify the server that this client is prepared to handle
                      expired password sandbox mode even if --batch was
                      specified.

Variables (--variable-name=value)
and boolean options {FALSE|TRUE}  Value (after reading options)
--------------------------------- ----------------------------------------
abort-source-on-error             FALSE
auto-rehash                       TRUE
auto-vertical-output              FALSE
binary-as-hex                     FALSE
character-sets-dir                (No default value)
column-type-info                  FALSE
comments                          FALSE
compress                          FALSE
debug-check                       FALSE
debug-info                        FALSE
database                          (No default value)
default-character-set             utf8mb4
delimiter                         ;
vertical                          FALSE
force                             FALSE
named-commands                    FALSE
ignore-spaces                     FALSE
init-command                      (No default value)
local-infile                      FALSE
no-beep                           FALSE
host                              (No default value)
html                              FALSE
xml                               FALSE
line-numbers                      TRUE
unbuffered                        FALSE
column-names                      TRUE
sigint-ignore                     FALSE
port                              3306
progress-reports                  TRUE
prompt                            \N [\d]>
protocol
quick                             FALSE
raw                               FALSE
reconnect                         TRUE
socket                            C:/xampp/mysql/mysql.sock
ssl                               FALSE
ssl-ca                            (No default value)
ssl-capath                        (No default value)
ssl-cert                          (No default value)
ssl-cipher                        (No default value)
ssl-key                           (No default value)
ssl-crl                           (No default value)
ssl-crlpath                       (No default value)
tls-version                       (No default value)
ssl-verify-server-cert            FALSE
table                             FALSE
user                              (No default value)
safe-updates                      FALSE
i-am-a-dummy                      FALSE
connect-timeout                   0
max-allowed-packet                16777216
net-buffer-length                 16384
select-limit                      1000
max-join-size                     1000000
secure-auth                       FALSE
show-warnings                     FALSE
plugin-dir                        (No default value)
default-auth                      (No default value)
binary-mode                       FALSE
connect-expired-password          FALSE

ASUS@LAPTOP-VJRH4MEH c:\xampp
# bye
'bye' is not recognized as an internal or external command,
operable program or batch file.

ASUS@LAPTOP-VJRH4MEH c:\xampp
# mysql -u root
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 11
Server version: 10.4.32-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> USE rental_mobil;
Database changed
MariaDB [rental_mobil]> INSERT INTO ketersediaan_mobil (tipe, mobil_tersedia, mobil_disewa)
    -> SELECT tipe, SUM(jumlah_mobil), 0 FROM mobil GROUP BY tipe;
Query OK, 13 rows affected (0.013 sec)
Records: 13  Duplicates: 0  Warnings: 0

MariaDB [rental_mobil]> SELECT * FROM ketersediaan_mobil WHERE id_mobil = 1;
ERROR 1054 (42S22): Unknown column 'id_mobil' in 'where clause'
MariaDB [rental_mobil]> SELECT * FROM ketersediaan_mobil;
+----+-------------+----------------+--------------+
| id | tipe        | mobil_tersedia | mobil_disewa |
+----+-------------+----------------+--------------+
|  1 | Convertible |             25 |            0 |
|  2 | Coupe       |             25 |            0 |
|  3 | Crossover   |             25 |            0 |
|  4 | Hatchback   |             25 |            0 |
|  5 | Limousine   |             25 |            0 |
|  6 | Minivan     |             25 |            0 |
|  7 | MPV         |             25 |            0 |
|  8 | Pickup      |             25 |            0 |
|  9 | Roadster    |             25 |            0 |
| 10 | Sedan       |             25 |            0 |
| 11 | SUV         |             25 |            0 |
| 12 | Van         |             25 |            0 |
| 13 | Wagon       |             25 |            0 |
+----+-------------+----------------+--------------+
13 rows in set (0.002 sec)

MariaDB [rental_mobil]> SELECT * FROM ketersediaan_mobil;
+----+-------------+----------------+--------------+
| id | tipe        | mobil_tersedia | mobil_disewa |
+----+-------------+----------------+--------------+
|  1 | Convertible |             25 |            0 |
|  2 | Coupe       |             25 |            0 |
|  3 | Crossover   |             25 |            0 |
|  4 | Hatchback   |             25 |            0 |
|  5 | Limousine   |             25 |            0 |
|  6 | Minivan     |             25 |            0 |
|  7 | MPV         |             25 |            0 |
|  8 | Pickup      |             25 |            0 |
|  9 | Roadster    |             25 |            0 |
| 10 | Sedan       |             25 |            0 |
| 11 | SUV         |             25 |            0 |
| 12 | Van         |             25 |            0 |
| 13 | Wagon       |             25 |            0 |
+----+-------------+----------------+--------------+
13 rows in set (0.001 sec)

MariaDB [rental_mobil]> INSERT INTO sewa_mobil (
    -> id_admin, id_tarif_mobil, id_mobil,
    -> tanggal_sewa, tanggal_kembali, no_identitas,
    -> nama, alamat, no_hp, email, lokasi)
    -> VALUES
    -> (1, 1, 1, NOW(), '2026-06-15', '2172032407060001', 'Fajri', 'Tanjungpinang', '082267276921', 'Fajri@gmail.com', 'Parawisata');
Query OK, 1 row affected, 1 warning (0.010 sec)

MariaDB [rental_mobil]> SELECT * FROM ketersediaan_mobil;
+----+-------------+----------------+--------------+
| id | tipe        | mobil_tersedia | mobil_disewa |
+----+-------------+----------------+--------------+
|  1 | Convertible |             25 |            0 |
|  2 | Coupe       |             25 |            0 |
|  3 | Crossover   |             25 |            0 |
|  4 | Hatchback   |             25 |            0 |
|  5 | Limousine   |             25 |            0 |
|  6 | Minivan     |             25 |            0 |
|  7 | MPV         |             25 |            0 |
|  8 | Pickup      |             25 |            0 |
|  9 | Roadster    |             25 |            0 |
| 10 | Sedan       |             24 |            1 |
| 11 | SUV         |             25 |            0 |
| 12 | Van         |             25 |            0 |
| 13 | Wagon       |             25 |            0 |
+----+-------------+----------------+--------------+
13 rows in set (0.001 sec)

MariaDB [rental_mobil]> DESCRIBE tarif_mobil;
+----------------+---------------+------+-----+---------+----------------+
| Field          | Type          | Null | Key | Default | Extra          |
+----------------+---------------+------+-----+---------+----------------+
| id_tarif_mobil | int(11)       | NO   | PRI | NULL    | auto_increment |
| id_mobil       | int(11)       | NO   | MUL | NULL    |                |
| lama_sewa      | int(11)       | NO   |     | NULL    |                |
| harga          | decimal(15,2) | NO   |     | NULL    |                |
| diskon         | varchar(10)   | YES  |     | NULL    |                |
+----------------+---------------+------+-----+---------+----------------+
5 rows in set (0.026 sec)

MariaDB [rental_mobil]> CREATE TRIGGER trg_tanggal_kembali
    -> BEFORE INSERT ON sewa_mobil
    -> FOR EACH ROW
    -> SET NEW.tanggal_kembali = DATE_ADD(NEW.tanggal_sewa, INTERVAL
    -> (SELECT lama_sewa FROM tarif_mobil WHERE id_tarif_mobil = NEW.id_tarif_mobil) DAY);
Query OK, 0 rows affected (0.015 sec)

MariaDB [rental_mobil]> INSERT INTO sewa_mobil (
    -> id_admin, id_tarif_mobil, id_mobil,
    -> tanggal_sewa, no_identitas,
    -> nama, alamat, no_hp, email, lokasi)
    -> VALUES
    -> (1, 1, 1, NOW(), '2172032407060001', 'Fajri', 'Tanjungpinang', '082267276921', 'Fajri@gmail.com', 'Parawisata');
Query OK, 1 row affected, 1 warning (0.017 sec)

MariaDB [rental_mobil]> SELECT id_sewa_mobil, tanggal_sewa, tanggal_kembali FROM sewa_mobil ORDER BY id_sewa_mobil DESC LIMIT 3;
+---------------+--------------+-----------------+
| id_sewa_mobil | tanggal_sewa | tanggal_kembali |
+---------------+--------------+-----------------+
|          2007 | 2026-06-13   | 2026-06-14      |
|          2006 | 2026-06-13   | 2026-06-15      |
|          2005 | 2026-06-13   | 2026-06-15      |
+---------------+--------------+-----------------+
3 rows in set (0.001 sec)

MariaDB [rental_mobil]> CREATE TRIGGER trg_batas_tipe
    -> BEFORE INSERT ON sewa_mobil
    -> FOR EACH ROW
    -> IF (SELECT COUNT(DISTINCT m.tipe) FROM sewa_mobil sm
    -> JOIN mobil m ON m.id_mobil = sm.id_mobil
    -> WHERE sm.nama = NEW.nama
    -> AND NOW() BETWEEN sm.tanggal_sewa AND sm.tanggal_kembali) >= 2
    -> THEN
    -> SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Penyewa sudah menyewa 2 tipe mobil berbeda';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '' at line 9
MariaDB [rental_mobil]> END IF;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'END IF' at line 1
MariaDB [rental_mobil]> CREATE TRIGGER trg_batas_tipe
    -> BEFORE INSERT ON sewa_mobil
    -> FOR EACH ROW
    -> IF (SELECT COUNT(DISTINCT m.tipe) FROM sewa_mobil sm
    -> JOIN mobil m ON m.id_mobil = sm.id_mobil
    -> WHERE sm.nama = NEW.nama
    -> AND NOW() BETWEEN sm.tanggal_sewa AND sm.tanggal_kembali) >= 2
    -> THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Penyewa sudah menyewa 2 tipe mobil berbeda'; END IF;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '' at line 8
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'END IF' at line 1
MariaDB [rental_mobil]> CREATE TRIGGER trg_batas_tipe
    -> BEFORE INSERT ON sewa_mobil
    -> FOR EACH ROW
    -> BEGIN
    -> IF (SELECT COUNT(DISTINCT m.tipe) FROM sewa_mobil sm
    -> JOIN mobil m ON m.id_mobil = sm.id_mobil
    -> WHERE sm.nama = NEW.nama
    -> AND NOW() BETWEEN sm.tanggal_sewa AND sm.tanggal_kembali) >= 2
    -> THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Penyewa sudah menyewa 2 tipe mobil berbeda'; END IF; END// DELIMITER;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '' at line 9
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'END IF' at line 1
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'END// DELIMITER' at line 1
MariaDB [rental_mobil]> Bye

ASUS@LAPTOP-VJRH4MEH c:\xampp
# bye
'bye' is not recognized as an internal or external command,
operable program or batch file.

ASUS@LAPTOP-VJRH4MEH c:\xampp
# mysql -u root
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 12
Server version: 10.4.32-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> use rental_mobil;
Database changed
MariaDB [rental_mobil]> DELIMITER //
MariaDB [rental_mobil]> CREATE TRIGGER trg_batas_tipe
    -> BEFORE INSERT ON sewa_mobil
    -> FOR EACH ROW
    -> BEGIN
    -> IF (SELECT COUNT(DISTINCT m.tipe) FROM sewa_mobil sm
    -> JOIN mobil m ON m.id_mobil = sm.id_mobil
    -> WHERE sm.nama = NEW.nama
    -> AND NOW() BETWEEN sm.tanggal_sewa AND sm.tanggal_kembali) >= 2
    -> THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Penyewa sudah menyewa 2 tipe mobil berbeda'; END IF; END// DELIMITER;
Query OK, 0 rows affected (0.006 sec)

    ->
    -> //
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'DELIMITER' at line 1
MariaDB [rental_mobil]> SHOW TRIGGERS FROM rental_mobil;
    -> //
+------------------------+--------+------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------+----------------+----------------------+----------------------+--------------------+
| Trigger                | Event  | Table      | Statement                                                                                                                                                                                                                                                                                             | Timing | Created                | sql_mode                                            | Definer        | character_set_client | collation_connection | Database Collation |
+------------------------+--------+------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------+----------------+----------------------+----------------------+--------------------+
| trg_tanggal_kembali    | INSERT | sewa_mobil | SET NEW.tanggal_kembali = DATE_ADD(NEW.tanggal_sewa, INTERVAL
(SELECT lama_sewa FROM tarif_mobil WHERE id_tarif_mobil = NEW.id_tarif_mobil) DAY)                                                                                                                                                     | BEFORE | 2026-06-13 14:31:00.39 | NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_general_ci   | utf8mb4_general_ci |
| trg_batas_tipe         | INSERT | sewa_mobil | BEGIN
IF (SELECT COUNT(DISTINCT m.tipe) FROM sewa_mobil sm
JOIN mobil m ON m.id_mobil = sm.id_mobil
WHERE sm.nama = NEW.nama
AND NOW() BETWEEN sm.tanggal_sewa AND sm.tanggal_kembali) >= 2
THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Penyewa sudah menyewa 2 tipe mobil berbeda'; END IF; END | BEFORE | 2026-06-13 14:43:49.59 | NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_general_ci   | utf8mb4_general_ci |
| tgr_log_sewa           | INSERT | sewa_mobil | INSERT INTO log_sewa(pesan, waktu)
VALUES (
CONCAT('Penyewa ', NEW.nama, 'sewa mobil ID ', NEW.id_mobil),
NOW()
)                                                                                                                                                                                     | AFTER  | 2026-06-13 11:17:32.32 | NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_general_ci   | utf8mb4_general_ci |
| trg_ketersediaan_mobil | INSERT | sewa_mobil | UPDATE ketersediaan_mobil
SET mobil_tersedia = mobil_tersedia - 1,
mobil_disewa = mobil_disewa + 1
WHERE tipe = (SELECT tipe FROM mobil WHERE id_mobil = NEW.id_mobil)                                                                                                                                | AFTER  | 2026-06-13 14:05:50.27 | NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_general_ci   | utf8mb4_general_ci |
| tgr_log_hapus_sewa     | DELETE | sewa_mobil | INSERT INTO log_hapus
(nama, waktu_dihapus)
VALUES
(OLD.nama, NOW())                                                                                                                                                                                                                                  | AFTER  | 2026-06-13 11:47:24.53 | NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_general_ci   | utf8mb4_general_ci |
+------------------------+--------+------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------+----------------+----------------------+----------------------+--------------------+
5 rows in set (0.016 sec)
                        DELIMITER ;
MariaDB [rental_mobil]> DELIMITER ;
MariaDB [rental_mobil]> INSERT INTO sewa_mobil (id_admin, id_tarif_mobil, id_mobil, tanggal_sewa, no_identitas, nama, alamat, no_hp, email, lokasi) VALUES (1, 1, 1, NOW(), '2172032407060001', 'Fajri', 'Tanjungpinang', '082267276921', 'Fajri@gmail.com', 'Parawisata');
Query OK, 1 row affected, 1 warning (0.010 sec)

MariaDB [rental_mobil]> INSERT INTO sewa_mobil (id_admin, id_tarif_mobil, id_mobil, tanggal_sewa, no_identitas, nama, alamat, no_hp, email, lokasi) VALUES (1, 2, 2, NOW(), '2172032407060001', 'Fajri', 'Tanjungpinang', '082267276921', 'Fajri@gmail.com', 'Parawisata');
Query OK, 1 row affected, 1 warning (0.004 sec)

MariaDB [rental_mobil]> INSERT INTO sewa_mobil (id_admin, id_tarif_mobil, id_mobil, tanggal_sewa, no_identitas, nama, alamat, no_hp, email, lokasi) VALUES (1, 3, 3, NOW(), '2172032407060001', 'Fajri', 'Tanjungpinang', '082267276921', 'Fajri@gmail.com', 'Parawisata');
ERROR 1644 (45000): Penyewa sudah menyewa 2 tipe mobil berbeda
MariaDB [rental_mobil]> CREATE TABLE ketersediaan_7hari (
    -> id INT AUTO_INCREMENT PRIMARY KEY,
    -> tipe VARCHAR(50),
    -> mobil_tersedia INT,
    -> tanggal_cek DATE
    -> );
Query OK, 0 rows affected (0.010 sec)

MariaDB [rental_mobil]> CREATE TRIGGER trg_ketersediaan_7hari
    -> AFTER INSERT ON sewa_mobil
    -> FOR EACH ROW
    -> INSERT INTO ketersediaan_7hari (tipe, mobil_tersedia, tanggal_cek)
    -> SELECT m.tipe, km.mobil_tersedia, DATE_ADD(NOW(), INTERVAL 7 DAY)
    -> FROM mobil m
    -> JOIN ketersediaan_mobil km ON km.tipe = m.tipe
    -> WHERE m.id_mobil = NEW.id_mobil;
Query OK, 0 rows affected (0.010 sec)

MariaDB [rental_mobil]> Bye

ASUS@LAPTOP-VJRH4MEH c:\xampp
# bye
'bye' is not recognized as an internal or external command,
operable program or batch file.

ASUS@LAPTOP-VJRH4MEH c:\xampp
# mysql -u root
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 13
Server version: 10.4.32-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> use rental_mobil;
Database changed
MariaDB [rental_mobil]> INSERT INTO sewa_mobil (id_admin, id_tarif_mobil, id_mobil, tanggal_sewa, no_identitas, nama, alamat, no_hp, email, lokasi)
    -> VALUES (1, 1, 1, NOW(), '2172032407060001', 'Fajri', 'Tanjungpinang', '082267276921', 'Fajri@gmail.com', 'Parawisata');
ERROR 1644 (45000): Penyewa sudah menyewa 2 tipe mobil berbeda
MariaDB [rental_mobil]> INSERT INTO sewa_mobil (id_admin, id_tarif_mobil, id_mobil, tanggal_sewa, no_identitas, nama, alamat, no_hp, email, lokasi) VALUES (1, 1, 1, NOW(), '1234567890123456', 'Budi', 'Tanjungpinang', '08123456789', 'budi@gmail.com', 'Parawisata');
Query OK, 1 row affected, 1 warning (0.003 sec)

MariaDB [rental_mobil]> SELECT * FROM ketersediaan_7hari;
+----+-------+----------------+-------------+
| id | tipe  | mobil_tersedia | tanggal_cek |
+----+-------+----------------+-------------+
|  1 | Sedan |             21 | 2026-06-20  |
+----+-------+----------------+-------------+
1 row in set (0.000 sec)

MariaDB [rental_mobil]>
