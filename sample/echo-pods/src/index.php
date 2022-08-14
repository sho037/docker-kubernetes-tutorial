<?php
require 'vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();
?>

<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>echo-pods</title>
    <style>
        table {
            width: 40%;
            table-layout: fixed;
            background: white;
        }
    </style>
</head>

<body style="background-color: <?php echo $_ENV['COLOR']; ?>;">

    <table>
        <tr>
            <th>ホスト名</th>
            <td><?php echo $_SERVER['SERVER_NAME']; ?></td>
        </tr>
        <tr>
            <th>IPアドレス</th>
            <td><?php echo $_SERVER['SERVER_ADDR']; ?></td>
        </tr>
        <tr>
            <th>ポート番号</th>
            <td><?php echo $_SERVER['SERVER_PORT']; ?></td>
        </tr>
        <tr>
            <th>現在時刻</th>
            <td><?php echo date('Y-m-d H:i:s'); ?></td>
        </tr>
        <tr>
            <th>カラーコード</th>
            <td><?php echo $_ENV['COLOR']; ?></td>
        </tr>
    </table>
</body>

</html>