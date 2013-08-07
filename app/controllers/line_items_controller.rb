class LineItemsController < ApplicationController
  include CurrentCart
  # before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, [:create, :update, :edit, :destroy]


  def index
    @line_items = LineItem.all
  end

  def show
  end

  def new
    @line_item = LineItem.new
  end

  def edit
  end

  def create
    @line_item = current_user.current_cart.line_items.build
    #making use of add product method
    @cart = Cart.find(@line_item.cart_id)
    @line_item.beer_id = params[:beer_id]
    @line_item.event_id = params[:event_id]
    # @beer = Beer.find(params[:beer_id])

    @line_item = @cart.add_beer(@line_item.beer_id)


    
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart,
          notice: 'Line item was successfully created.' }
        format.json { render action: 'show',
          status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors,
          status: :unprocessable_entity }
      end
    end
  end

  
  def update

    @line_item = @cart.remove_beer(@line_item.beer_id)
    redirect_to carts_path

    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.json { head :no_content }
    end
  end

  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

end