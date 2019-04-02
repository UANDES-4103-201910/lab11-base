#!/bin/bash
rails g model User name:string lastname:string email:string password:string address:string
rails g model EventVenue name:string address:string capacity:integer
rails g model Event name:string description:string start_date:date event_venue:references
rails g model TicketZone zone:string
rails g model TicketType event:references price:integer ticket_zone:references
rails g model Order user:references
rails g model Ticket ticket_type:references order:references
