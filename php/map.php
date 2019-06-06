<style>
table {
    border: 0;
    border-collapse: collapse;
}
table td {
    border: 0;
    padding: 0;
}
.layer {
position: absolute;
top: 0;
left: 0;
opacity: .5;
}
</style>
<?php

$appid = 'f06510a5a302b510a3673a98275b071b';

showLayer('https://cartodb-basemaps-c.global.ssl.fastly.net/light_all/6', 'z-index: 0; opacity: 1');
showLayer('http://tile.openweathermap.org/map/precipitation_new/6', 'z-index: 1', $appid);

function showLayer($baseUrl, $style = '', $appid = '') {
    echo '<table class="layer" style="'.$style.'">';
    foreach (range(19, 23) as $y) {
        echo '<tr>';
        foreach (range(30, 38) as $x) {
            echo '<td>';
            $tile = "$baseUrl/$x/$y.png?appid=$appid";
            echo '<img src="'.$tile.'"/>';
            echo '</td>';
        }
        echo '</tr>';
    }
    echo '</table>';
}
