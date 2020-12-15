<?php

include('./db_connect.php');
function executeReq($cnx, $req)
{
    return $cnx->query($req);
}
