module Castronaut

  module Presenters

    class Logout < Base

      def represent!
        ticket_granting_ticket = Castronaut::Models::TicketGrantingTicket.find_by_ticket(ticket_granting_ticket_cookie) 
        
        cookies.delete 'tgt'
        controller.response.delete_cookie('tgt')

        if ticket_granting_ticket
          Castronaut::Models::ProxyGrantingTicket.clean_up_proxy_granting_tickets_for(ticket_granting_ticket.username)
          ticket_granting_ticket.destroy
        end
        
        messages << "You have successfully logged out."
        
        if (Castronaut.config.redirect_on_logout rescue false) && url.present?
          redirect url
        else
          render :logout
        end
                
        self
      end
    
    end

  end
  
end
