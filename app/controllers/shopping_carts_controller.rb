class ShoppingCartsController < ApplicationController
  def add_ticket

    # Set the shopping cart if unset
    session[:shopping_cart] ||= []

    begin
      ticket_type = TicketType.find(shopping_cart_params[:ticket_type_id])
    rescue
      logger.debug("[ShoppingCartsController::add_ticket] no ticket found!")
      redirect_back fallback_location: root_path, flash: { error: "Invalid event or ticket type!" } and return
    end

    shopping_cart_params[:amount].to_i.times {
      session[:shopping_cart] << shopping_cart_params[:ticket_type_id]
    }

    redirect_back fallback_location: root_path, flash: { notice: "Ticket added to shopping cart!" } and return

    #render plain: "success! " + session[:shopping_cart].inspect
  end

  def remove_ticket
    # TODO
  end

  def index
    # Not much to do here...
  end

  private

  def shopping_cart_params
    params.permit(:utf8, :_method, :authenticity_token, :commit, :id, :ticket_type_id, :amount)
  end

end
