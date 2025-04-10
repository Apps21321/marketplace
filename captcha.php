<?php
session_start();

$code = substr(str_shuffle("ABCDEFGHJKLMNPQRSTUVWXYZ23456789"), 0, 5);
$_SESSION['captcha'] = $code;

header('Content-Type: image/png');
$img = imagecreatetruecolor(100, 30);
$bg = imagecolorallocate($img, 30, 30, 30);
$text = imagecolorallocate($img, 255, 255, 255);
imagefilledrectangle($img, 0, 0, 100, 30, $bg);
imagestring($img, 5, 20, 8, $code, $text);
imagepng($img);
imagedestroy($img);
?>
