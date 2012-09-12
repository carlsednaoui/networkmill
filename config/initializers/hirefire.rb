# Make sure to add the following
## $ heroku config:add APP_NAME=<appname> --app <appname>
## $ heroku config:add HEROKU_API_KEY=<apikey> --app <appname>
## $ heroku config:add HIREFIRE_EMAIL=<heroku email> --app <appname>
## No longer needed since patch: $ heroku config:add HIREFIRE_PASSWORD=<heroku api key> --app <appname>

HireFire.configure do |config|

  # Enable this to work on staging environment
  if Rails.env.production? or Rails.env == "staging"
    config.environment = :heroku
   else
    config.environment = :local
  end

  # config.environment      = nil # default in production is :heroku. default in development is :noop
  config.max_workers      = 3   # default is 1
  config.min_workers      = 0   # default is 0
  config.job_worker_ratio = [
      { :jobs => 1,   :workers => 1 },
      { :jobs => 15,  :workers => 2 },
      { :jobs => 35,  :workers => 3 }
    ]
end

# Override hirefire to make it work with Heroku stack
class HireFire::Environment::Heroku
  require 'heroku-api'
  private
  def workers(amount = nil)
    heroku = Heroku::API.new(:api_key => ENV['HEROKU_API_KEY']) 
    if amount.nil?
      # return client.info(ENV['APP_NAME'])[:workers].to_i
      # return client.ps(ENV['APP_NAME']).select {|p| p['process'] =~ /worker.[0-9]+/}.length
      return heroku.get_ps(ENV['APP_NAME']).body.select {|p| p['process'] =~ /worker.[0-9]+/}.length
    end
    # client.set_workers(ENV['APP_NAME'], amount)
    # return client.ps_scale(ENV['APP_NAME'], {"type" => "worker", "qty" => amount})
    return heroku.post_ps_scale(ENV['APP_NAME'], "worker", amount) 
    rescue #RestClient::Exception
    HireFire::Logger.message("Worker query request failed with #{ $!.class.name } #{ $!.message }")
    nil
  end
end

# quick override to ensure that HireFire is activated on Heroku. The change is that it is looking for
# ::Rails.env.production? instead of ENV.include?('HEROKU_UPID')
module HireFire
  module Environment

    module ClassMethods
      
      def environment
        @environment ||= HireFire::Environment.const_get(
          if environment = HireFire.configuration.environment
            environment.to_s.camelize
          else
            ["production", "staging"].include? ::Rails.env ? 'Heroku' : 'Noop'
          end
        ).new
      end

      # def hirefire_hire
      #     if Resque.working == [] && Resque.info[:pending] > 1
      #     	Resque.workers.each do |w| w.unregister_worker end
      #       environment.hire
      #     end
      # end

      # Make sure that no worker is stuck in the queue
      def hirefire_hire
        delayed_job = ::Delayed::Job.new
        if delayed_job.working == 0 \
        or delayed_job.jobs    == 1
          environment.hire
        end
      end
    end
  end
end