$(document).on('turbolinks:load', () => {
   $(".ticket_amount").on("change", (e) => {

       let input = $(e.target);
       let ttid = input.attr("data-ticket-type-id");
       let amnt = input.attr("data-amount");
       let change_amnt = input.val();

       $.post('/shopping_cart/update',
            { amount: change_amnt, ticket_type_id: ttid} )
        .done((data) => {
            $("p.notice").html("Succeeded updating cart!");
            $("#shopping_cart_count").html(data.html);
            $("#order_total").html(data.total);
        })
        .fail((e) => {
            $("p.alert").html("Failed to update cart!");
            input.val(amnt);
            console.log("Failure!")
        });
   });
});