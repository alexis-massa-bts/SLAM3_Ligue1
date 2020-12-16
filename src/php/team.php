<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/materialize.min.css">
    <link rel="stylesheet" href="../css/team.css">
    <title>Equipe</title>
    <?php
    include("header.php");
    include('./db_requests.php');
    ?>
</head>

<body>
    <?php
    $team = executeReq($cnx, "select * from equipe where nom = '" . $_GET['nom'] . "'");
    $line = $team->fetch();
    ?>
    <div class="container">
        <div class="left">
            <img id="team-logo" src="<?php echo $line['image'] ?>" />
        </div>
        <div class="right">
            <div id="name"><?php echo $line['nom']; ?></div>
            <div id="city">Ville : <a href="<?php echo 'https://www.google.com/maps/place/' . $line['ville'] . '/' ?>" target="_blank"> <?php echo $line['ville'] ?></a></div>
            <div id="stadium"><span name="stade">Stade : <a href="<?php echo 'https://www.google.com/search?q=stade+'.$line['stade'].'&oq=stade+'.ucfirst($line['stade']) ?>" target="_blank"><?php echo $line['stade']; ?></a></span></div>
        </div>
    </div>
    <div class="container">

    </div>
    <?php
    ?>
</body>

</html>