<?php
require 'vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

date_default_timezone_set('Asia/Tokyo');
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
            table-layout: fixed;
            background: white;
            border-collapse: separate;
            border-spacing: 20px 5px;
        }

        body {
            font-size: x-large;
        }
    </style>
</head>

<body style="background-color: <?php echo $_ENV['COLOR']; ?>;">

    <table>
        <tr>
            <th>Host</th>
            <td><?php echo $_SERVER['SERVER_NAME']; ?></td>
        </tr>
        <tr>
            <th>Pod-IP</th>
            <td><?php echo $_SERVER['SERVER_ADDR']; ?></td>
        </tr>
        <tr>
            <th>Port</th>
            <td><?php echo $_SERVER['SERVER_PORT']; ?></td>
        </tr>
        <tr>
            <th>Pod-Name</th>
            <td><?php include('/etc/hostname'); ?></td>
        </tr>
        <tr>
            <th>Time</th>
            <td><?php echo date('Y-m-d H:i:s'); ?></td>
        </tr>
        <tr>
            <th>Image</th>
            <td><a href="https://hub.docker.com/r/muruu1/echo-pods" target="_blank" rel="noopener noreferrer">muruu1/echo-pods</a>:v1.0</td>
        </tr>
        <tr>
            <th>Color</th>
            <td><?php echo $_ENV['COLOR']; ?></td>
        </tr>
    </table>

    <!-- v3.0の自動リロード -->
    <script>
        setTimeout(function() {
            location.reload();
        }, 6000);
    </script>
</body>

</html>