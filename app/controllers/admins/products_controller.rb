class Admins::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save # 入力されたデータをdbに保存する。
      redirect_to admins_product_path(@product.id)
      flash[:success] = "商品を登録しました"
    else
      flash[:danger] = "必要情報を入力してください"
      render "admins/products/new"
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admins_product_path(@product)
      flash[:success] = "商品を更新しました"
    else # if文でエラー発生時と正常時のリンク先を枝分かれにしている。
      flash[:danger] = "商品の更新に失敗しました"
      render "admins/products/edit"
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :explanation, :image, :genre_id, :price, :is_enabled)
  end
end
