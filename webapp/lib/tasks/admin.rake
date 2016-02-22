namespace :admin do

  admin_email = "admin@local.host"

  desc "Generate admin user"
  task :create_user => :environment do
    if User.where(email: admin_email).exists?
      puts "!! admin user already exists !!"
    else
      rand_pass = (("a".."z").to_a + ("A".."Z").to_a).sample(8).join
      user = User.new email:                  admin_email,
                      password:               rand_pass
      user.save!
      puts "!! create admin user: #{admin_email} : #{rand_pass} !!"
    end
  end

  desc "Reset admin user password"
  task :reset_passwd => :environment do
    user = User.where(email: admin_email).first
    rand_pass = (("a".."z").to_a + ("A".."Z").to_a).sample(8).join
    user.password = rand_pass
    user.save!
    puts "!! reset admin password: #{admin_email} : #{rand_pass} !!"
  end

  desc "Set token"
  task :set_token, ['token'] => :environment do |task, args|
    token = Token.new token: args["token"],
              created_at: Time.now
    token.save!
  end

  desc "Get tokens"
  task :get_tokens => :environment do
    tokens = Token.all
    puts tokens
  end

  desc "Delete tokens"
  task :delete_tokens => :environment do
    Token.delete_all()
  end
end
