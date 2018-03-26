class ProductsController < ApplicationController
  # 在以下每個 function 之前，先執行 find_product function (in private section)
  before_action :find_product, only: [:show, :edit, :update, :destroy, :checkout]

  def checkout
    if @product
      nonce = params[:payment_method_nonce]

      result = Braintree::Transaction.sale(
        amount: @product.price,
        payment_method_nonce: nonce
        )

      if result
        redirect_to products_path, notice: "刷卡成功"
      else
        # 錯誤處理
      end
    else
      # 錯誤處理
    end
  end

  def index
    @products = Product.all
  end

  def show
    # 產生一個 @client_token 的實體變數，準備給 View 使用
    @client_token = Braintree::ClientToken.generate
    # @client_token = gateway.client_token.generate
    # get "/client_token" do
    #   gateway.client_token.generate
    # end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: "商品新增完成"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: "商品更新成功"
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "商品已刪除"
  end

  private
  def find_product
    @product = Product.find_by(id: params[:id])
    redirect_to products_path, notice: "無此商品" unless @product
  end

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

  # 以下 gateway 方法，從 Braintree_rails_example 抄過來的
  # def gateway
  #   env = ENV["sandbox"] # not sure what this line for?

  #   @gateway ||= Braintree::Gateway.new(
  #     :environment => env && env.to_sym, # what is to_sym?
  #     :merchant_id => ENV["wcdpm7wgjy8bmbnm"],
  #     :public_key => ENV["kzr2qrmyvk76tynk"],
  #     :private_key => ENV["a7e35f46d14f683fa53dc49d73fd2065"],
  #   )
  # end
end
