<?php

function executeReq($cnx, $req)
{
    return $cnx->query($req);
}
