<?php

/**
 * Description of db
 *
 * @author amassa
 */
try {
    // hidestream
    $cnx = new PDO('pgsql:host=localhost;dbname=Ligue1;port=5432', 'postgres', 'P@ssw0rdsio');
    array(PDO::ATTR_PERSISTENT => true);
} catch (PDOException $e) {
    die("Database connexion error: " . $e->getMessage());
}
