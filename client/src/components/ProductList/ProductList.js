// client/src/components/ProductList/ProductList.js

import React, { useEffect, useState } from "react";
import axios from "axios";

function ProductList() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      const result = await axios.get("/shop/api/products");
      setProducts(result.data);
    };
    fetchData();
  }, []);
  return (
    <div>
      {products.map((product) => (
        <div key={product.productId}>
          <div>{product.name}</div>
          <div>${product.price}</div>
          <img src={product.imageUrl} alt={product.name} />
        </div>
      ))}
    </div>
  );
}
export default ProductList;
