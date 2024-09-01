<?php
	include 'includes/session.php';
	$conn = $pdo->open();
	$output = array('error'=>false);
    $id =  $_POST['id'];
    try{
        $stmt = $conn->prepare("UPDATE orders SET status=:status WHERE id=:id");
        $stmt->execute(['status'=>'Completed','id'=>$id]);
        $output['message'] = 'Order Completed';
    }
    catch(PDOException $e){
        $output['error'] = true;
        $output['message'] = $e->getMessage();
    }
    $pdo->close();
	echo json_encode($output);
?>