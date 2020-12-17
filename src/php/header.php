<nav>
    <div class="nav-wrapper">
        <a href="http://localhost:3000/src/" class="brand-logo right">Logo</a>
        <ul id="nav-mobile" class="left">
            <?php
            $menu = array(
                "Accueil" => "http://localhost:3000/src/",
                "Equipes" => "http://localhost:3000/src/php/teams.php",
                "Rencontres" => "http://localhost:3000/src/php/matches.php",
                "Classement" => "http://localhost:3000/src/php/ranking.php"
            );
            foreach ($menu as $page => $link) {
                echo '<li><a href="' . $link . '">' . $page . '</a></li>';
            }
            ?>
        </ul>
    </div>
</nav>