<nav>
    <div class="nav-wrapper">
        <a href="#" class="brand-logo right">Logo</a>
        <ul id="nav-mobile" class="left hide-on-med-and-down">
            <?php
            $menu = array(
                "Equipes" => "php/teams.php",
                "Classement" => "php/ranking.php",
                "Rencontres" => "php/matches.php"
            );
            foreach ($menu as $page => $link) {
                echo '<li><a href="' . $link . '">' . $page . '</a></li>';
            }
            ?>
        </ul>
    </div>
</nav>