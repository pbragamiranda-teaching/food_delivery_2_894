class SessionsView
  def ask_user_for(something)
    puts "What is your #{something}"
    print ">"
    gets.chomp
  end

  def wrong_credentials
    puts "Wrong credentials...try again."
  end

  def login_sucessful
    puts "Welcome!"
  end
end
