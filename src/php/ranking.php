<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/materialize.min.css">
    <title>Ligue 1</title>
    <?php
    include("header.php");
    include("db_requests.php");
    ?>
</head>

<body>
    <table id="table-ranking" class="centered highlight responsive-table">
        <thead id="ranking-head">
            <tr>
                <th>Teams</th>
                <th>Points</th>
                <th>Played</th>
                <th>Won</th>
                <th>Draw</th>
                <th>Lost</th>
                <th>Goals scored</th>
                <th>Goals taken</th>
            </tr>
        </thead>
        <tbody>
            <?php
            $ranking = executeReq($cnx, "
            select nom, points, played, won, draw, lost, scored, taken
            from score
            inner join equipe on equipe.id_equipe = score.id_equipe
            order by points;");

            for ($i = 0; $i < $ranking->rowCount(); $i++) {
                $line = $ranking->fetch();
            ?>
                <tr class="ranking-row">
                    <td class="ranking-cell"><?php echo $line['nom'] ?></td>
                    <td class="ranking-cell"><?php echo $line['points'] ?></td>
                    <td class="ranking-cell"><?php echo $line['played'] ?></td>
                    <td class="ranking-cell"><?php echo $line['won'] ?></td>
                    <td class="ranking-cell"><?php echo $line['draw'] ?></td>
                    <td class="ranking-cell"><?php echo $line['lost'] ?></td>
                    <td class="ranking-cell"><?php echo $line['scored'] ?></td>
                    <td class="ranking-cell"><?php echo $line['taken'] ?></td>
                </tr>



            <?php
            }
            ?>
        </tbody>
    </table>

</body>
<footer>
    <?php
    include("footer.php");
    ?>
</footer>

</html>