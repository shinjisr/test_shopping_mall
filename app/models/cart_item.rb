class CartItem
  # 可以讀取編號和數量
  attr_reader :product_id, :quantity

  # 初始數量為 1
  def initialize(product_id, quantity = 1)
    @product_id = product_id
    @quantity = quantity
  end

  def increment(n = 1)
    @quantity += n
  end

  # 透過 Product_id 比對 Product 資料庫查出是什麼商品
  def product
    Product.find_by(id: product_id)
  end

  def price
    product.price * quantity
  end

  # def remove
  # end
end
