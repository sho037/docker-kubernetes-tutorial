<?php
session_start();

function rand_color()
{
    $_SESSION['color'] = '#' . str_pad(dechex(mt_rand(0, 0xFFFFFF)), 6, '0', STR_PAD_LEFT);
    $_SESSION['cnt'] = 1;
}

if ($_SESSION['cnt'] == null) {
    rand_color();
}
?>

<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>echo-pods</title>
</head>

<body style="background-color: <?php echo $_SESSION['color']; ?>;">
    <?php echo $_SESSION['color']; ?>
    <?php echo $_SERVER['REMOTE_ADDR']; ?>
</body>

</html>