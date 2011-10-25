class AddExtraAttributesToServiceTicketsAndTicketGrantingTickets < ActiveRecord::Migration
  def self.up
    add_column :service_tickets, :extra_attributes, :string, :null => true
    add_column :ticket_granting_tickets, :extra_attributes, :string, :null => true
  end

  def self.down
    remove_column :service_tickets, :extra_attributes
    remove_column :ticket_granting_tickets, :extra_attributes
  end
end
