<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/materialize.min.css">
    <link rel="stylesheet" href="css/index.css">
    <title>Ligue 1 - Home</title>
    <?php
    include("php/header.php");
    ?>
</head>

<body>
    <div class="grid-container">
        <div id="tl" class="grid-box"><a href="./php/teams.php">Equipes</a></div>
        <div id="tr" class="grid-box"><a href="./php/matches.php">Rencontres</a></div>
        <div id="bl" class="grid-box"><a href="./php/ranking.php">Classement</a></div>
        <div id="br" class="grid-box"><a href="./php/stats.php">Statistiques</a></div>
    </div>
</body>
<footer>
    <?php
    include("php/footer.php");
    ?>
</footer>

</html>