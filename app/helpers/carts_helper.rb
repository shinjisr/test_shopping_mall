module CartsHelper
  def current_cart
    # 回傳||左邊的值，但假如左邊回傳nil或false，改成把右邊的值指定給左邊，並回傳。
    # 等於為 @cart 指定一個預設值 "Cart.from_hash(session[:cart9487])"
    @cart ||= Cart.from_hash(session[Cart::Sessionkey])
  end
end
