<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/materialize.min.css">

    <title>Ligue 1 - Rencontres</title>
    <?php
    include('header.php');
    include('./db_requests.php');
    ?>
</head>

<body>
    <p>Plusieurs rencontres sont passées, au hasard, donc pas toutes le premier jour</p>
    <ul class="collection with-header">
        <?php
        $matches = executeReq($cnx, "select * from rencontre order by date_match");
        $currDate = '1';
        for ($i = 0; $i < $matches->rowCount(); $i++) {
            $line = $matches->fetch();
            //$currDate = $line['date_match'];
            if ($line['date_match'] == $currDate) {
        ?>
                <li class="collection-item">
                    <span><?php echo $line['etat'] ?></span> <br>
                    <span>Equipe <?php echo $line['id_domicile'] ?></span>
                    <span> - </span>
                    <span><?php echo $line['score_domicile'] ?></span>
                    <span> : </span>
                    <span><?php echo $line['score_visiteur'] ?></span>
                    <span> - </span>
                    <span>Equipe <?php echo $line['id_visiteur'] ?></span> <br>
                    <label for="arbitre"></label>Arbitré par : <span name="arbitre"><?php echo $line['arbitre'] ?></span>
                </li>
            <?php
            } else if ($line['date_match'] != $currDate) {
            ?>
                <li class="collection-header">
                    <h4><?php echo $line['date_match'] ?></h4>
                </li>
        <?php
                $currDate = $line['date_match'];
            }
        }
        ?>
    </ul>
    <?php
    ?>
</body>
<footer>
    <?php
    include("footer.php");
    ?>
</footer>

</html>