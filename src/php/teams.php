<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/materialize.min.css">
    <link rel="stylesheet" href="../css/teams.css">
    <title>Ligue 1 - Teams</title>
    <?php
    include("header.php");
    include('./db_requests.php');
    ?>
</head>

<body>
    <?php
    $teams = executeReq($cnx, "select * from equipe order by nom");
    for ($i = 0; $i < $teams->rowCount(); $i++) {
        $line = $teams->fetch();
    ?>
        <div class="row card-div">
            <div class="col s12 m3 l4 card-box">
                <div class="card blue-grey darken-1">
                    <a href="<?php echo './team.php?nom=' . $line['nom'] ?>">
                        <div class="card-flex card-content white-text">
                            <div class="left">
                                <img class="team-logo" src="<?php echo $line['image'] ?>" />
                            </div>
                            <div class="right">
                                <span class="card-title"><?php echo $line['nom']; ?></span>
                                <div class="card_info"><label for="stade">Stade : </label><span name="stade"><?php echo $line['stade']; ?></span></div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        <?php
    }
        ?>
        </div>
</body>
<footer>
    <?php
    include("footer.php");
    ?>
</footer>

</html>