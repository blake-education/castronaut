module Castronaut

  module Presenters

    class Base

      MissingCredentialsMessage = "Please supply a username and password to login."

      attr_reader :controller, :your_mission
      attr_accessor :messages

      delegate :params, :request, :to => :controller
      delegate :cookies, :env, :to => :request

      def initialize(controller, format = :html)
        @controller = controller
        @messages = []
        @format = format
        @your_mission = nil

        Castronaut.logger.info "Presenting #{self.class.to_s} with params: #{params.clone.delete_if{|k,v| k == "password"}}"
      end

      def url
        params['url']
      end

      def ticket_granting_ticket_cookie
        cookies['tgt']
      end

      alias ticket_generating_ticket_cookie ticket_granting_ticket_cookie

      def client_host
        env['HTTP_X_FORWARDED_FOR'] || env['REMOTE_HOST'] || env['REMOTE_ADDR']
      end

      def login_ticket
        Castronaut::Models::LoginTicket.generate_from(client_host).ticket
      end

      def ticket
        params['ticket']
      end

      def proxy_granting_ticket_url
        params['pgtUrl']
      end

      def service
        params['service']
      end

      def renewal
        params['renew']
      end

      def username
        params['username'].to_s.strip
      end

      def password
        params['password'].to_s.strip
      end

      def gateway?
        %w(true 1).include? params['gateway']
      end

      def redirection_loop?
        params.has_key?('redirection_loop_intercepted')
      end

    protected

      def render template, options = {}
        options[:layout] ||= false unless @format == :html

        @your_mission = lambda do
          controller.content_type @format
          render_options = {
            :locals => {:presenter => self}
          }.merge(options)
          template_filename = "#{template}.#{@format}".to_sym
          
          case @format.to_sym
          when :xml
            controller.builder(template_filename, render_options)
          else
            controller.erb(template_filename, render_options)
          end
        end
      end

      def redirect uri, code = 303
        @your_mission = lambda {
          if @format == :json
            controller.content_type :json
            controller.erb( {:redirect => uri}.to_json, :layout => false )
          else
            controller.redirect uri, code
          end
        }
      end

      def setup_http_request(url, auth_status, payload)
        request = Net::HTTP::Post.new(url.path, { 'port' => url.port.to_s })
        request.set_form_data('cas_json_payload' => {'cas_status' => auth_status, 'cas_details' => payload}.to_json)
        request
      end

      def setup_http_session(url)
        session = Net::HTTP.new(url.host, url.port.to_s)
        session.use_ssl = true if url.scheme == 'https'
        session
      end

    end

  end

end
