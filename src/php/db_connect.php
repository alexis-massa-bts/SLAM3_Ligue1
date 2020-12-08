<?php

/**
 * Description of db
 *
 * @author amassa
 */
try {
    // hidestream
    $cnx = new PDO('pgsql:host=localhost;dbname=Ligue1;port=5433', 'postgres', 'AlxsMsa351');
    array(PDO::ATTR_PERSISTENT => true);
} catch (PDOException $e) {
    die("Database connexion error: " . $e->getMessage());
}
