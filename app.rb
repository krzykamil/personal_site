# frozen_string_literal: true

require_relative 'models'
# require_relative 'env'
require 'sequel'
require 'roda'
# require 'tilt/sass'
require 'ruby_jard'

class Bibliotheca < Roda
  opts[:check_dynamic_arity] = false
  opts[:check_arity] = :warn

  plugin :default_headers,
         'Content-Type' => 'text/html',
         # 'Strict-Transport-Security'=>'max-age=16070400;', # Uncomment if only allowing https:// access
         'X-Frame-Options' => 'deny',
         'X-Content-Type-Options' => 'nosniff',
         'X-XSS-Protection' => '1; mode=block'

  plugin :route_csrf
  plugin :flash
  plugin :assets, css: 'app.scss', css_opts: { style: :compressed, cache: false }, timestamp_paths: true, js: 'MainElm.js'
  plugin :render, escape: true
  plugin :view_options
  plugin :public
  plugin :hash_routes

  logger = ENV['RACK_ENV'] == 'test' ? Class.new { def write(_) end }.new : $stderr
  plugin :common_logger, logger

  plugin :not_found do
    @page_title = 'File Not Found'
    view(content: '')
  end

  if ENV['RACK_ENV'] == 'development'
    plugin :exception_page
    class RodaRequest
      def assets
        exception_page_assets
        super
      end
    end
  end

  plugin :error_handler do |e|
    case e
    when Roda::RodaPlugins::RouteCsrf::InvalidToken
      @page_title = 'Invalid Security Token'
      response.status = 400
      view(content: '<p>An invalid security token was submitted with this request, and this request could not be processed.</p>')
    else
      $stderr.print "#{e.class}: #{e.message}\n"
      warn e.backtrace
      next exception_page(e, assets: true) if ENV['RACK_ENV'] == 'development'

      @page_title = 'Internal Server Error'
      view(content: '')
    end
  end

  plugin :sessions,
         key: '_Bibliotheca.session',
         # cookie_options: {secure: ENV['RACK_ENV'] != 'test'}, # Uncomment if only allowing https:// access
         secret: ENV.send((ENV['RACK_ENV'] == 'development' ? :[] : :delete), 'BIBLIOTHECA_SESSION_SECRET')

  Unreloader.require('routes') {}

  route do |r|
    r.public
    r.assets
    check_csrf!
    r.hash_routes('')
    render("index")
  end

  Sequel::Model.plugin :json_serializer

end
