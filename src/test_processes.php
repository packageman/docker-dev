<?php

$processCount = 5;

for ($i = 0; $i < $processCount; ++$i ) {
    $pid = pcntl_fork();
    if ($pid == 0) {
        // 子进程
        sleep(rand(1,5)); // 模拟延时
        $myPid = getmypid();
        echo "I am $i/$processCount, my pid is $myPid". PHP_EOL;
        exit(0); // 执行完后退出
    }
}

$n = 0;
while ($n < $processCount) {
    $status = -1;
    $pid = pcntl_wait($status, WNOHANG);
    if ($pid > 0) {
        echo "{$pid} exit" . PHP_EOL;
        $n++;
    }
}

?>
