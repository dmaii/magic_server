Dir['../lib/'].each {|file| require file } 
require 'test/unit'

class ServerTest < Test::Unit::TestCase
   def test_trim_request
      test_header = 'GET /boo HTTP/1.1' 
      assert_equal 'boo', Webserver::trim_heading(test_header, 'GET')
   end 

   def test_get_content_type
      test_trimmedrequest = "/css/application.css"
      assert_equal Webserver::get_content_type(test_trimmedrequest), "text/css"
   end 

   def test_server_init_port
      args = ['p', '3334']
      server = Webserver::Server.new(args)
   end 

   def test_status_message
      assert_equal Webserver::StatusMessage[100], 'Continue'
   end 

   def test_servlet_mounts
      server = Webserver::Server.new([]) 
      server.mount_all('./app')
   end 

   def test_cookie_parse
      cookie = 'boo=boo; boo2=boo2'
      test_val = Webserver::Cookie::parse(cookie)
      expected_val = {'boo' => 'boo', 'boo2' => 'boo2'}
      assert_equal(expected_val, test_val)
   end 

   def test_cookie
      cookie = Webserver::Cookie.new('schlafen', 'boo')
      cookie.version = 3
      test_val = cookie.to_s
      expected_val = 'schlafen=boo; Version=3'
      assert_equal(expected_val, test_val)
      cookie.expires = Time.now
   end 

end 
