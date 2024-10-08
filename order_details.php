<?php
include 'includes/session.php';
$conn = $pdo->open();
$output = '';
try{ 		
    $stmt = $conn->prepare("SELECT  *, products.name AS prodName, category.name AS catName, orders.id AS id, orders.rating AS orderRating FROM orders INNER JOIN products ON orders.product_id=products.id INNER JOIN category ON products.category_id=category.id WHERE status=:status AND user_id=:user_id ORDER BY created_at DESC");
    $stmt->execute(['status'=>$_GET['status'],'user_id'=>$user['id']]);
    if($stmt->rowCount() !== 0){
        foreach($stmt as $order){
            $image = (!empty($order['photo'])) ? 'images/'.$order['photo'] : 'images/noimage.jpg';
            $hide = $order['status'] == 'Pending'? '': 'hidden';
            $rate = $order['status'] == 'Completed' && !$order['orderRating']? '' : 'hidden';
            $cancelled = $order['status'] == 'Cancelled'? 'cancelled' : '';
            $rated = $order['orderRating'] ? 'rated' : '';
            $output .= "
            <div class='order-card ".$cancelled." ".$rated."'>
                <div class='child-order-card'>
                    <a href=".$image."><img src=".$image." alt='' width='64px' height='64px'></a>
                    <div class='order-content'>
                        <div class='titles'>
                            <p class='title'>".$order['prodName']."</p>
                        </div>
                        <medium class='category'>Category: ".$order['catName']."</medium>
                        <p>x<b class='quantity'>".$order['quantity']."</b></p>
                    </div>
                </div>
                <div class='trailing'>
                    <p><b>&#x20B1; ".number_format($order['total'],2)."</b></p>
                    <button type='button' class='cancel' data-id='".$order['id']."' $hide>Cancel</button>
                    <button type='button' class='rate' data-id='".$order['id']."' data-product='".$order['product_id']."' data-order='".$order['id']."'  data-toggle='modal' data-target='#rating' $rate>Rate</button>
                </div>
            </div>";
        }
    }else{
        $output = "
        <div class='text-center empty-content'>
        <img src='images/empty.png' class='img-fluid' width='256px'>
        <h4>Empty</h4>
        <p>This section is currently empty.</p>
        </div>";
    }
}
catch(PDOException $e){
    echo "There is some problem in connection: " . $e->getMessage();
}
$pdo->close();
echo json_encode($output);
?>