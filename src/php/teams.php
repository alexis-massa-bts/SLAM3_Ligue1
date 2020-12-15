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
            <div class="col s12 m4 card-box">
                <div class="card blue-grey darken-1">
                    <div class="card-content white-text">
                        <span class="card-title"><?php echo $line['nom']; ?></span>
                        <div class="card_info"><label for="stade">Stade : </label><span name="stade"><?php echo $line['stade']; ?></span></div>
                    </div>
                </div>
            </div>
        </div>
    <?php
    }
    ?>
</body>
<footer>
    <?php
    include("footer.php");
    ?>
</footer>

</html>