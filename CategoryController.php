<?php

class CategoryController {

    // Метод для отображения категории
    public function showCategory($categoryId) {
        // Подключаемся к базе данных
        try {
            $pdo = new PDO("mysql:host=localhost;dbname=marketplace", "marketuser", "password");
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            echo "Ошибка подключения: " . $e->getMessage();
            exit;
        }

        // Получаем категорию из базы данных по ID
        $stmt = $pdo->prepare("SELECT * FROM categories WHERE id = ?");
        $stmt->execute([$categoryId]);
        $category = $stmt->fetch(PDO::FETCH_ASSOC);

        // Если категория не найдена, выводим сообщение
        if (!$category) {
            echo "Категория с ID " . $categoryId . " не найдена";
            exit;
        }

        // Выводим информацию о категории для отладки
        echo "<pre>";
        print_r($category);
        echo "</pre>";

        // Получаем товары для этой категории
        $stmt = $pdo->prepare("SELECT * FROM products WHERE category_id = ?");
        $stmt->execute([$categoryId]);
        $products = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Выводим товары для отладки
        echo "<pre>";
        print_r($products);
        echo "</pre>";

        // Подключаем шаблон для отображения страницы категории
        include '../templates/category_page.php';
    }
}
