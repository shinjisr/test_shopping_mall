class CartsController < ApplicationController
  def add
    # cart = Cart.from_hash(session[Cart::Sessionkey]) # session 的 key Cart::Sessionkey 可以挑選自己喜歡的(位於 models/Cart.rb)
    # 這一段寫到 CartsHelper 內，再到 application_controller 去 include ，讓所有繼承的 controller 都可以使用

    #
    current_cart.add_item(params[:id])
    session[Cart::Sessionkey] = current_cart.serialize

    redirect_to products_path, notice: "已加入購物車"
  end

  def edit
    # 嘗試從購物車內移除已選購的物品
    current_cart.remove_item(params[:id])
    # 轉成 session hash 儲存購物車料
    session[Cart::Sessionkey] = current_cart.serialize
    redirect_to cart_path, notice: "已移除所選商品"
  end

  def destroy
  session[Cart::Sessionkey] = nil
  redirect_to products_path, notice: "購物車已清空"
  end

end
