namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_uploads
  end
end

def make_users
  admin = User.create!(email:    "example@railstutorial.org",
                       password: "asdfasdf")
end

def make_uploads
  users = User.all(limit: 6)
  5.times do
    link = "http://res.cloudinary.com/seveneightninea/image/upload/v1396258418/spkat30pwex0jhlaenuy.jpg"
    users.each { |user| user.uploads.create!(link: link, sepia: true, watermark: true, vertflip: true) }
  end
end