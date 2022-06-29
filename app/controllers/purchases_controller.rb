class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index

  def index
    @purchase_post = PurchasePost.new
  end

  def new
    @purchase_post = PurchasePost.new
  end

  def create
    @purchase_post = PurchasePost.new(purchase_params)
    if @purchase_post.valid?
      pay_item
      @purchase_post.save
      redirect_to root_path
    else
      render :index
    end
  end

  def show
    @purchase = Purchase.find(params[:id])
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchase_post).permit(:post_code, :prefecture_id, :municipality, :house_number, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, price: @item.price, token: params[:token]
    )
  end

  def move_to_index
    redirect_to root_path if @item.purchase.present?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: @purchase_post.token,
      currency: 'jpy'
    )
  end
end