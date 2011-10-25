require 'json'
require 'json/add/rails'

module Castronaut

  module Presenters

    class ProcessLogin < Base

      def represent!
        @login_ticket = params['lt']

        login_ticket_validation_result = Castronaut::Models::LoginTicket.validate_ticket(@login_ticket)

        if login_ticket_validation_result.invalid?
          messages << login_ticket_validation_result.message
          @login_ticket = Castronaut::Models::LoginTicket.generate_from(client_host).ticket

          render :login # TODO: STATUS 401
          return self
        end

        if username.blank? || password.blank?
          messages << MissingCredentialsMessage
          @login_ticket = Castronaut::Models::LoginTicket.generate_from(client_host).ticket

          render :login # TODO: STATUS 401
          return self
        end

        @login_ticket = Castronaut::Models::LoginTicket.generate_from(client_host).ticket

        Castronaut.logger.info("#{self.class} - Logging in with username: #{username}, login ticket: #{login_ticket}, service: #{service}")

        authentication_result = Castronaut::Adapters.selected_adapter.authenticate(username, password)

        if authentication_result.valid?
          fire_authentication_success_notice('username' => username, 'client_host' => client_host, 'service' => service)

          extra_attributes = authentication_result.extra_attributes
          ticket_granting_ticket = Castronaut::Models::TicketGrantingTicket.generate_for(username, client_host, extra_attributes)
          controller.response.set_cookie "tgt", ticket_granting_ticket.to_cookie

          if service.blank?
            messages << "You have successfully logged in."
          else
            service_ticket = Castronaut::Models::ServiceTicket.generate_ticket_for(service, client_host, ticket_granting_ticket)

            if service_ticket && service_ticket.service_uri
              redirect service_ticket.service_uri
              return self
            else
              messages << "The target service your browser supplied appears to be invalid. Please contact your system administrator for help."
            end
          end

        else
          fire_authentication_failure_notice('username' => username, 'client_host' => client_host, 'service' => service)
          messages << authentication_result.error_message
        end

        if messages.any?
          render :login
        end

        self
      end

    private

      def fire_notice(auth_status, payload)
        return unless Castronaut.config.can_fire_callbacks?

        callback_url = Castronaut.config.callbacks["on_authentication_#{auth_status}"]
        return if callback_url.blank?

        url = URI.parse(callback_url)
        request = setup_http_request(url, auth_status, payload)

        session = setup_http_session(url)
        session.start { |http| http.request(request) }
      end

      def fire_authentication_success_notice(details)
        Thread.new do
          fire_notice 'success', details
        end
      end

      def fire_authentication_failure_notice(details)
        fire_notice 'failed', details
      end

    end

  end

end
