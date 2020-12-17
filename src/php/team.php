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
    <a id="back" href="./teams.php">Retour</a>
    <?php
    $team = executeReq($cnx, "select * from equipe where nom = '" . $_GET['nom'] . "'");
    $line = $team->fetch();
    ?>
    <div class="grid">
        <div id="top-left" class="container">
            <div class="left">
                <img id="team-logo" src="<?php echo $line['image'] ?>" />
            </div>
            <div class="right">
                <div id="name" class="card-title"><?php echo $line['nom']; ?></div>
                <div id="city">Ville : <a href="<?php echo 'https://www.google.com/maps/place/' . $line['ville'] . '/' ?>" target="_blank"> <?php echo $line['ville'] ?></a></div>
                <div id="stadium"><span name="stade">Stade : <a href="<?php echo 'https://www.google.com/search?q=stade+' . $line['stade'] . '&oq=stade+' . ucfirst($line['stade']) ?>" target="_blank"><?php echo $line['stade']; ?></a></span></div>
            </div>
        </div>
        <div id="top-right" class="container">
            <?php
            $ranking = executeReq($cnx, "
                select nom, points, played, won, draw, lost, scored, taken
                from score
                inner join equipe on equipe.id_equipe = score.id_equipe
                order by points desc;");
            $i = 0;
            for ($i = 0; $i < $ranking->rowCount(); $i++) {
                $line = $ranking->fetch();
                if (strcmp(strtolower($line['nom']), strtolower($_GET['nom'])) == 0) {
                    if ($line['points'] == 0) {
            ?>
                        <div class="top">
                            <div id="" class="card-title">Classement : <?php echo 'Non Classé' ?></div>
                        </div>
                        <div class="bottom">
                            <div class="card-info">Points : <?php echo $line['points'] ?></div>
                            <div class="card-info">Matchs joués : <?php echo $line['played'] ?></div>
                            <div class="card-info">Matchs gagnés : <?php echo $line['won'] ?></div>
                            <div class="card-info">Matchs nuls : <?php echo $line['draw'] ?></div>
                            <div class="card-info">Matchs perdus : <?php echo $line['lost'] ?></div>
                            <div class="card-info">Buts marqués : <?php echo $line['scored'] ?></div>
                            <div class="card-info">Buts encaissés : <?php echo $line['taken'] ?></div>
                        <?php
                    } else {
                        ?>
                            <div class="top">
                                <div id="" class="card-title">Classement : <?php echo $i + 1 ?></div>
                            </div>
                            <div class="bottom">
                                <div class="card-info">Points : <?php echo $line['points'] ?></div>
                                <div class="card-info">Matchs joués : <?php echo $line['played'] ?></div>
                                <div class="card-info">Matchs gagnés : <?php echo $line['won'] ?></div>
                                <div class="card-info">Matchs nuls : <?php echo $line['draw'] ?></div>
                                <div class="card-info">Matchs perdus : <?php echo $line['lost'] ?></div>
                                <div class="card-info">Buts marqués : <?php echo $line['scored'] ?></div>
                                <div class="card-info">Buts encaissés : <?php echo $line['taken'] ?></div>
                    <?php
                    }
                }
            }
                    ?>

                            </div>
                        </div>
        </div>
        <div id="bottom" class="container">
            <div class="top">
                <div id="" class="card-title">Rencontres à venir</div>
            </div>
            <div class="bottom">
                <ul class="collection with-header list">
                    <?php
                    $id = executeReq($cnx, "select id_equipe from equipe where nom = '" . $_GET['nom'] . "'");
                    $line = $id->fetch();
                    $idC = $line['id_equipe'];

                    $matches = executeReq($cnx, "
                                    select rencontre.id_domicile, rencontre.id_visiteur, rencontre.date_match, rencontre.score_domicile, rencontre.score_visiteur, rencontre.arbitre
                                    from rencontre
                                    where rencontre.date_match>=current_date-365 and (rencontre.id_domicile = (
                                        select equipe.id_equipe from equipe where equipe.id_equipe = " . $idC . ")
                                        or rencontre.id_visiteur = (select equipe.id_equipe from equipe where equipe.id_equipe = " . $idC . ")
                                    ) order by rencontre.date_match desc;
                                    ");
                    $currDate = '1';
                    for ($i = 0; $i < $matches->rowCount(); $i++) {
                        $line = $matches->fetch();

                    ?>
                        <li class="collection-item">
                            <div class="left">
                                <div class="match-content date">Date : <?php echo $line['date_match'] ?></div>
                            </div>
                            <div class="right">
                                <div class="match-content">
                                    <?php
                                    $name = executeReq($cnx, "select nom from equipe where id_equipe = " . $line['id_domicile']);
                                    $line2 = $name->fetch();
                                    $name = $line2['nom'];
                                    echo $name;
                                    ?>
                                    -
                                    <?php echo $line['score_domicile'] ?>
                                    VS
                                    <?php echo $line['score_visiteur'] ?>
                                    -
                                    <?php
                                    $name = executeReq($cnx, "select nom from equipe where id_equipe = " . $line['id_visiteur']);
                                    $line2 = $name->fetch();
                                    echo $line2['nom']; ?>
                                </div>
                                <div name="arbitre">Arbitré par : <?php echo $line['arbitre'] ?></div>
                            </div>
                        </li>
                    <?php

                    }
                    ?>
                </ul>
            </div>
        </div>
        <?php
        ?>
</body>

</html>