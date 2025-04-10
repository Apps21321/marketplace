<?php include __DIR__ . '/header.php'; ?>

<h2>Категория: <?= htmlspecialchars($category['name']) ?></h2>
<p><?= htmlspecialchars($category['description']) ?></p>

<div class="products">
    <h3>Товары категории:</h3>
    <?php if (!empty($products)): ?>
        <div class="product-list">
            <?php foreach ($products as $product): ?>
                <div class="product-item">
                    <h4><?= htmlspecialchars($product['name']) ?></h4>
                    <p>Цена: <?= htmlspecialchars($product['price']) ?> ₽</p>
                    <a href="/product/<?= $product['id'] ?>">Перейти к товару</a>
                </div>
            <?php endforeach; ?>
        </div>
    <?php else: ?>
        <p>Товары не найдены в этой категории.</p>
    <?php endif; ?>
</div>

<?php include __DIR__ . '/footer.php'; ?>
