class Cart
  # 設定 Sessionkey, 讓其他地方可以取用
  Sessionkey = :cart9487

  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def add_item(product_id)
    # 之後嘗試建立 found_item 方法，讓其他方法也可取用
    found_item = items.find { |item| item.product_id == product_id }

    if found_item
      found_item.increment
    else
      # 若比對 product_id 不在陣列裡，new 一個 CartItem 後加入陣列
      @items << CartItem.new(product_id)
    end
  end

  # 嘗試新增移除購物車內物品的功能
  def remove_item(params_product_id)
    # 從 Items 陣列移除指定的 CartItem 物件- 180327
    items.delete_if {|item| item.product_id == params_product_id}
  end

  def empty?
    items.empty?
  end

  def total_price
    items.reduce(0) { |sum, item| sum + item.price }
  end

  # 因為要使用 session 存購物車的資料，所以要把購物車物件轉換成 hash 格式
  # session_hash = { "items" => [{"product_1" => 1, "quantity" => 1}, {"product_2" => 2, "quantity" => 2}]}

  def serialize
    all_items = items.map { |item|
      { "product_id" => item.product_id, "quantity" => item.quantity}
    }

    { "items" => all_items }
  end

  # 從 HASH 內容轉換回 CartItem 物件
  # 實際上購物車資料存在於 session (hash) 中
  def self.from_hash(hash)
    if hash.nil?
      new []
    else
      new hash["items"].map { |item_hash|
        CartItem.new(item_hash["product_id"], item_hash["quantity"])
      }
    end
  end
end
