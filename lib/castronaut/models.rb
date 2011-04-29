module Castronaut::Models

  MODELS = [LoginTicket, ProxyGrantingTicket, ProxyTicket, ServiceTicket, TicketGrantingTicket]

  def self.each(&block)
    MODELS.each(&block)
  end

end
