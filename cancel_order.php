<?php
	include 'includes/session.php';
	$conn = $pdo->open();
	$output = array('error'=>false);
	$user = $_SESSION['user'];
    $id =  $_POST['id'];
    try{
        $stmt = $conn->prepare("UPDATE orders SET status=:status WHERE id=:id");
        $stmt->execute(['status'=>'Cancelled','id'=>$id]);
        $output['message'] = 'Order Added';
    }
    catch(PDOException $e){
        $output['error'] = true;
        $output['message'] = $e->getMessage();
    }
    $pdo->close();
	echo json_encode($output);
?>