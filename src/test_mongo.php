<?php

$connection = new MongoClient("mongodb://mongodb:27017");
$db = $connection->test;
$collection = $db->createCollection("merrychris");
echo "create collection successfully!\n";

$document = array( 
    "title" => "MongoDB", 
    "description" => "database", 
    "likes" => 100,
    "url" => "https://merrychris.com",
    "by", "byron"
);

$collection->insert($document);
echo "insert document successfully!\n";

?>
