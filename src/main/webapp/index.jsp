<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Modern Store</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Poppins:wght@600;700&display=swap" rel="stylesheet">

<style>
:root{
  --bg:#f5f7fb;
  --card:#ffffff;
  --primary:#0f172a;
  --accent:#2563eb;
  --accent-soft:#e8f0ff;
  --muted:#6b7280;
  --border:#e5e7eb;
  --radius:16px;
}

*{box-sizing:border-box;margin:0;padding:0}
body{
  font-family:Inter, sans-serif;
  background:
    radial-gradient(circle at 10% 10%, #eef2ff, transparent 40%),
    radial-gradient(circle at 90% 20%, #e0f2fe, transparent 40%),
    var(--bg);
  color:var(--primary);
}

header{
  position:sticky;top:0;z-index:10;
  background:rgba(255,255,255,.75);
  backdrop-filter:blur(12px);
  border-bottom:1px solid var(--border);
  padding:14px 28px;
  display:flex;justify-content:space-between;align-items:center;
}

.logo{font-family:Poppins;font-size:22px}

.search{
  display:flex;align-items:center;gap:10px;
  background:white;border:1px solid var(--border);
  padding:10px 14px;border-radius:999px;
  min-width:260px;
  box-shadow:0 6px 18px rgba(15,23,42,.06);
}
.search input{border:none;outline:none;font-size:14px;width:100%}

.hero{
  text-align:center;color:white;
  min-height:460px;padding:70px 20px;
  border-bottom-left-radius:var(--radius);
  border-bottom-right-radius:var(--radius);
  background:
    linear-gradient(120deg, rgba(37,99,235,.85), rgba(15,23,42,.9)),
    url('https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?auto=format&fit=crop&w=1400&q=80') center/cover no-repeat;
}
.hero h1{font-size:48px;margin-bottom:10px}
.btn-primary{
  margin-top:20px;
  background:var(--accent);color:white;
  padding:12px 22px;border:none;border-radius:10px;
  cursor:pointer;font-weight:600;
  box-shadow:0 12px 30px rgba(37,99,235,.35);
}

section{padding:60px 28px}

.grid{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
  gap:24px;
}

.cat-card{
  background:var(--card);
  border:1px solid var(--border);
  border-radius:var(--radius);
  padding:22px;text-align:center;
  transition:.25s ease;
  box-shadow:0 10px 30px rgba(15,23,42,.05);
  cursor:pointer;
}
.cat-card:hover{
  transform:translateY(-8px);
  box-shadow:0 25px 60px rgba(15,23,42,.12);
}

.products{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
  gap:24px;
}

.product{
  position:relative;
  background:white;
  border:1px solid var(--border);
  border-radius:var(--radius);
  overflow:hidden;
  transition:.25s ease;
}
.product:hover{
  transform:translateY(-10px);
  box-shadow:0 30px 70px rgba(15,23,42,.15);
}
.product img{width:100%;height:220px;object-fit:cover}
.product-body{padding:16px}
.product h5{margin-bottom:8px}
.add-btn{
  margin-top:10px;
  width:100%;
  padding:10px;
  background:var(--primary);
  color:white;border:none;border-radius:10px;
  cursor:pointer;
}
.add-btn:hover{background:var(--accent)}

footer{
  margin-top:60px;
  border-top:1px solid var(--border);
  padding:30px;text-align:center;
  color:var(--muted);
}
</style>
</head>

<body>

<header>
  <div class="logo">ModernStore</div>
  <div class="search">
    <input type="search" id="searchInput" placeholder="Search products...">
  </div>
</header>

<div class="hero">
  <h1>Discover Premium Products</h1>
  <p>Beautiful design. Modern experience.</p>
  <button class="btn-primary">Shop Now</button>
</div>

<section>
  <h2>Categories</h2>
  <div class="grid" id="categories"></div>
</section>

<section>
  <h2>Products</h2>
  <div class="products" id="products"></div>
</section>

<footer>
  © 2026 ModernStore. All rights reserved.
</footer>

<script>
const categories = [
  {id:'phones', name:'Smartphones'},
  {id:'laptops', name:'Laptops'},
  {id:'audio', name:'Audio'},
  {id:'wearables', name:'Wearables'}
];

const products = [
  {id:1, name:'iPhone 15', category:'phones', price:999, img:'https://images.unsplash.com/photo-1695048133142-1a20484d2569'},
  {id:2, name:'MacBook Pro', category:'laptops', price:1999, img:'https://images.unsplash.com/photo-1517336714731-489689fd1ca8'},
  {id:3, name:'Headphones', category:'audio', price:199, img:'https://images.unsplash.com/photo-1518441902110-7f24c5d5f6c5'},
  {id:4, name:'Smart Watch', category:'wearables', price:299, img:'https://images.unsplash.com/photo-1511732351661-0b3b0f4f78a4'}
];

const catContainer = document.getElementById('categories');
const prodContainer = document.getElementById('products');
const searchInput = document.getElementById('searchInput');

function renderCategories(){
  categories.forEach(cat=>{
    const el=document.createElement('div');
    el.className='cat-card';
    el.innerText=cat.name;
    el.onclick=()=>filterProducts(cat.id);
    catContainer.appendChild(el);
  });
}

function renderProducts(list){
  prodContainer.innerHTML='';
  list.forEach(p=>{
    const el=document.createElement('div');
    el.className='product';
    el.innerHTML=`
      <img src="${p.img}?auto=format&fit=crop&w=600&q=60">
      <div class="product-body">
        <h5>${p.name}</h5>
        <div>$${p.price}</div>
        <button class="add-btn">Add to Cart</button>
      </div>`;
    prodContainer.appendChild(el);
  });
}

function filterProducts(cat){
  renderProducts(products.filter(p=>p.category===cat));
}

searchInput.addEventListener('input',e=>{
  const q=e.target.value.toLowerCase();
  renderProducts(products.filter(p=>p.name.toLowerCase().includes(q)));
});

renderCategories();
renderProducts(products);
</script>

</body>
</html>
