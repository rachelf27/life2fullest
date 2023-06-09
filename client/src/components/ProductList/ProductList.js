import React, { useEffect, useState } from 'react';
import axios from 'axios';

function ProductList() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      const result = await axios.get('/api/products');
      setProducts(result.data);
    };
    fetchData();
  }, []); // the empty array means this effect runs once when the component mounts
  return (
    <div>
      {products.map((product) => (
        <div key={product.id}>
          <div>{product.name}</div>
          <div>${product.price}</div>
          <img src={product.url} alt={product.name} />
        </div>
      ))}
    </div>
  );}
export default ProductList;
