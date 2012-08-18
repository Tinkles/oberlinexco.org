namespace :bootstrap_admins do

  ADMIN_EMAILS = ['ihm@cs.oberlin.edu', 'mbalchcr@oberlin.edu', 'exco@oberlin.edu']

  desc 'add ihm, mbc, and exco as admins'
  task :add_admins => :environment do
    User.where(:email => ADMIN_EMAILS).each do |user|
      user.admin = true
      user.save!
    end
  end

  desc 'remove all admins'
  task :remove_admins => :environment do
    User.all.each do |user|
      user.admin = false
      user.save!
    end
  end

end
