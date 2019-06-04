class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order_summary = {}
    @order.tickets.each do |ticket|
      if !@order_summary.key?(ticket.ticket_type)
        @order_summary[ticket.ticket_type] = 1
      else
        @order_summary[ticket.ticket_type] += 1
      end
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.delivery_address = DeliveryAddress.new

    # Get the tickets in the shopping cart
    ticket_types = helpers.shopping_cart_get_tickets()
    @required_tickets = {}

    ticket_types.each do |k,v|
      tt = TicketType.find(k)
      @required_tickets[tt] = v
    end

    # Add tickets to the order
    ticket_types.each do |k,v|
      tt = TicketType.find(k)
      v.times do |i|
        t = Ticket.new(ticket_type: tt)
        @order.tickets << t
      end
    end

  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    # Get the tickets in the shopping cart
    tickets = helpers.shopping_cart_get_tickets()

    total = 0

    # Add tickets to the order
    tickets.each do |k,v|
      tt = TicketType.find(k)
      total += tt.price * v
      v.times do |i|
        t = Ticket.new(ticket_type: tt)
        @order.tickets << t
      end
    end

    @order.user = current_user
    @order.total = total

    respond_to do |format|
      if @order.save(order_params)
        # Reset the shopping cart!
        session[:shopping_cart] = []
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        flash[:notice] = 'Failed to complete your order.'
        format.html { redirect_to action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(delivery_address_attributes: [:id, :recipient_fullname, :line1, :line2, :city, :country])
    end
end
