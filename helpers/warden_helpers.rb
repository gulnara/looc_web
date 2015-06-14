module WardenHelpers
  # from github.com/jsmestad/sinatra_warden

  # support for multiple user levels
  # NotImplementedError = Class.new(StandardError)

  def warden
    request.env['warden']
  end

  def authenticated?
    warden.authenticated?
  end

  def authorized?
    # support for multiple user levels
    # NotImplementedError
    warden.authenticated?
  end

  def current_user
    warden.user 
  end

  def logged_in?
    !!current_user
  end

  def authorize!(opts={})
    unless authenticated? && authorized?
      session[:return_to] = opts[:redirect] || request.url
      throw(:warden)
    end
  end

  def previous_path_or(url)
    url = session[:return_to] || url 
    session[:return_to] = nil 
    url 
  end
end