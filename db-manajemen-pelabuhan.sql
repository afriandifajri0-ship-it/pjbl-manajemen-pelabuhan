Setting environment for using XAMPP for Windows.
ASUS@LAPTOP-VJRH4MEH c:\xampp
# mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 15
Server version: 10.4.32-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> USE db_manajemen_pelabuhan;
Database changed
MariaDB [db_manajemen_pelabuhan]> CREATE TABLE pelabuhan (
    -> id_pelabuhan INT AUTO_INCREMENT PRIMARY KEY,
    -> nama_pelabuhan VARCHAR(100) NOT NULL,
    -> kota VARCHAR(50) NOT NULL,
    -> status_dermaga VARCHAR(20) NOT NULL
    -> );
Query OK, 0 rows affected (0.027 sec)

MariaDB [db_manajemen_pelabuhan]>
