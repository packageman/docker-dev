<?php
   $redis = new Redis();
   $redis->connect('redis', 6379);
   echo "Connection to server sucessfully\n";
   echo "Server is running: " . $redis->ping();
?>
