class ShoppingCartsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    # Get the tickets in the shopping cart
    ticket_types = helpers.shopping_cart_get_tickets()
    @required_tickets = {}

    ticket_types.each do |k,v|
      tt = TicketType.find(k)
      @required_tickets[tt] = v
    end

    @total = helpers.shopping_cart_total()
  end

  def update
    begin
      amount = params[:amount].to_i
      ticket_type = params[:ticket_type_id]

      if amount < 0
        render status: 500
      end

      amount_in_cart = session[:shopping_cart].count(ticket_type)

      if amount < amount_in_cart # Should tickets be removed
        delta = amount_in_cart - amount
        delta.times do |i|
          session[:shopping_cart].delete_at(session[:shopping_cart].index(ticket_type))
        end
      elsif amount > amount_in_cart # Should more tickets be added
        delta = amount - amount_in_cart
        delta.times do |i|
          session[:shopping_cart] << ticket_type
        end
      end

      respond_to do |f|
        response = { status: "ok", message: "Success", cart: session[:shopping_cart],
                     total: helpers.shopping_cart_total(),
                     html: "(" + session[:shopping_cart].length.to_s() + ")" }
        f.json { render json: response, status: :created, location: "/" }
      end
    rescue RuntimeError => e
      respond_to do |f|
        f.json { render json: { :status => "Failure" }, status: :unprocessable_entity }
      end
    end
  end

  def add_ticket

    # Set the shopping cart if unset
    session[:shopping_cart] ||= []

    begin
      ticket_type = TicketType.find(shopping_cart_params[:ticket_type_id])
    rescue
      redirect_back fallback_location: root_path, flash: { error: "Invalid event or ticket type!" } and return
    end

    shopping_cart_params[:amount].to_i.times {
      session[:shopping_cart] << shopping_cart_params[:ticket_type_id]
    }

    redirect_back fallback_location: root_path, flash: { notice: "Ticket added to shopping cart!" } and return

    #render plain: "success! " + session[:shopping_cart].inspect
  end

  private

  def shopping_cart_params
    params.permit(:utf8, :_method, :authenticity_token, :commit, :id, :ticket_type_id, :amount)
  end

end
