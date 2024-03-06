require 'thor'
require_relative '../config/environment'

class ProjectLoggerCLI < Thor

  desc "create_user EMAIL PASS [NAME]", "Creates a regular user"
  def create_user(email, password, name = nil)
    print "Creating #{email} / #{password} / #{name} ... "
    user = User.create!(email: email, password: password, name: name)
    puts "> ID #{user.id} -- Done!"
  end

  desc "create_user EMAIL PASS [NAME]", "Creates an admin user"
  def create_admin(email, password, name = nil)
    print "Creating #{email} / #{password} / #{name} ... "
    user = User.create!(email: email, password: password, name: name, admin: true)
    puts "> ID #{user.id} -- Done!"
  end

end

