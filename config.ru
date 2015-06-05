require './app'

use Rack::Static, :urls => ["/js", "/css", "/img"], :root => "public"

run Sinatra::Application