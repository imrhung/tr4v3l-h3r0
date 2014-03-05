<?php
// Bucket Name
$bucket="mytempbucket";
if (!class_exists('S3'))require_once('S3.php');

//AWS access info
if (!defined('awsAccessKey')) define('awsAccessKey', 'AKIAJIWOJ6L32GWAUUUQ');
if (!defined('awsSecretKey')) define('awsSecretKey', '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');

$s3 = new S3(awsAccessKey, awsSecretKey);
$s3->putBucket($bucket, S3::ACL_PUBLIC_READ);
?>