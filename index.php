
<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();


// Выводим маршрут для отладки
$request = trim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/');
echo "Запрос: " . $request;  // Этот вывод покажет путь, который приходит на сервер


$publicRoutes = ['login', 'register', 'captcha.php'];
$request = trim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/');

// Блокировка доступа ко всем страницам, кроме авторизации и регистрации
if (!in_array($request, $publicRoutes) && !isset($_SESSION['user_id'])) {
    include '../templates/welcome.php';
    exit;
}

$request = trim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/');

// Защита: редирект на /login если не авторизован
$auth_required_routes = ['ticket', 'cart', 'checkout'];
if (in_array($request, $auth_required_routes) && !isset($_SESSION['user_id'])) {
    header("Location: /login");
    exit;
}

// Защита: если пользователь не активирован — редиректим на /payment
$exempt_routes = ['login', 'register', 'logout', 'payment', 'captcha', 'admin'];
if (isset($_SESSION['user_id']) && !in_array($request, $exempt_routes)) {
    $pdo = new PDO("mysql:host=localhost;dbname=marketplace", "marketuser", "password");
    $stmt = $pdo->prepare("SELECT status, type FROM users WHERE id = ?");
    $stmt->execute([$_SESSION['user_id']]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && $user['type'] !== 'admin' && $user['type'] !== 'moderator' && $user['status'] !== 'active') {
        header("Location: /payment");
        exit;
    }
}




switch ($request) {
    case '':
        include '../templates/dashboard.php';
        break;

    case preg_match('/^category\/(\d+)$/', $request, $matches):
        // Если запрос вида /category/{id}, извлекаем id и передаем в CategoryController
        echo "Обрабатываем категорию с ID: " . $matches[1];  // Печатаем ID категории для отладки
        include '../src/Controllers/CategoryController.php';
        $categoryId = $matches[1];
        (new CategoryController())->showCategory($categoryId);
        break;
		
case 'home':
    include '../src/Controllers/HomeController.php';
    (new HomeController())->index();
    break;

case 'product':
    include '../src/Controllers/ProductController.php';
    (new ProductController())->showProduct();
    break;

    case 'login':
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            include '../src/Controllers/AuthController.php';
            (new AuthController())->handleLogin($_POST);
        } else {
            include '../templates/login.php';
        }
        break;

    case 'register':
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            include '../src/Controllers/AuthController.php';
            (new AuthController())->handleRegister($_POST);
        } else {
            include '../templates/register.php';
        }
        break;

    case 'logout':
        include 'logout.php';
        break;

    case 'admin':
        if (!isset($_SESSION['user_type']) || ($_SESSION['user_type'] !== 'admin' && $_SESSION['user_type'] !== 'moderator')) {
            http_response_code(403);
            echo "<h2 style='color:red;'>Доступ запрещён</h2>";
            exit;
        }
        include '../src/Controllers/AdminController.php';
        (new AdminController())->index();
        break;

    case 'admin/settings':
        include '../src/Controllers/AdminController.php';
        (new AdminController())->settings();
        break;

    case 'admin/transactions':
        include '../src/Controllers/AdminController.php';
        (new AdminController())->transactions();
        break;

case 'admin/users':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->users();
    break;

case 'admin/users/create':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->createUser();
    break;

case 'admin/users/delete':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->deleteUser();
    break;

case 'admin/users/update':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->updateUser();
    break;

case 'admin/users/update_status':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->updateStatus();
    break;
	
case 'admin/users/details':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->getUserDetails();
    break;

case 'admin/products':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->products();
    break;



case 'admin/products/create':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->createProduct();
    break;

case 'admin/products/delete':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->deleteProduct();
    break;

case 'admin/products/details':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->getProductDetails();
    break;

case 'admin/products/update':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->updateProduct();
    break;

case 'admin/reviews':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->reviews();
    break;

case 'admin/reviews/delete':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->deleteReview();
    break;

case 'admin/categories':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->categories();
    break;

case 'admin/categories/create':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->createCategory();
    break;

case 'admin/categories/delete':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->deleteCategory();
    break;

case 'admin/banners':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->banners();
    break;

case 'admin/banners/create':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->createBanner();
    break;

case 'admin/banners/delete':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->deleteBanner();
    break;


case 'admin/announcements':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->announcements();
    break;

case 'admin/announcements/create':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->createAnnouncement();
    break;

case 'admin/announcements/delete':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->deleteAnnouncement();
    break;

case 'admin/nav':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->nav();
    break;

case 'admin/nav/create':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->createNav();
    break;

case 'admin/nav/delete':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->deleteNav();
    break;


case 'admin/tickets':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->tickets();
    break;

case 'admin/tickets/delete':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->deleteTicket();
    break;


case 'admin/logs':
    include '../src/Controllers/AdminController.php';
    (new AdminController())->logs();
    break;



    case 'admin/broadcast':
        include '../templates/admin_broadcast.php';
        break;


    case 'ticket':
        include '../templates/ticket.php';
        break;

case 'cart':
    include '../src/Controllers/CartController.php';
    (new CartController())->viewCart();
    break;


    case 'checkout':
        include '../templates/checkout.php';
        break;

    case 'payment':
        include '../templates/payment.php';
        break;

    default:
        http_response_code(404);
        echo "404 Not Found";
        break;
}
?>
