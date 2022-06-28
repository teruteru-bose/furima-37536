class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index

  def index
    @purchase_post = PurchasePost.new
  end

  #newは不必要？
  def new
    @purchase_post = PurchasePost.new
  end

  def create
    @purchase_post = PurchasePost.new(purchase_params)
    if @purchase_post.valid?
      @purchase_post.save
      redirect_to root_path
    else
      render :index
    end
  end

  #showは不必要？
  def show
    @purchase = Purchase.find(params[:id])
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchase_post).permit(:post_code, :prefecture_id, :municipality, :house_number, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

  def move_to_index
    if @item.purchase.present?
      redirect_to root_path
    end
  end

end