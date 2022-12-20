# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

FIRSTNAMES = [
  "Simon", "Genevieve", "Shirley", "Ryland", "Kayden", "Annabel", "Mireya", "Shyanne", "Ashtyn", "Kaitlin", "Jessie", "Nevaeh"
]

LASTNAMES = [
  "Knapp", "Hurley", "Armstrong", "Durham", "Randolph", "Kelly", "Barker", "Farmer", "Little", "Buck", "Mccann", "Harrington"
]

5.times {
  user = User.create(firstname:FIRSTNAMES.sample, lastname:LASTNAMES.sample)

  #create medical record for @user for last 45 days
  (Date.today - 60.days..Date.today).each do |day|

    #create 4 recods per day
    4.times do 
      user.medical_records.create(
        created_at:rand(day.beginning_of_day..day.end_of_day), #set random time during the day span
        level: rand(20..600) #set random level
      ) 
    end

  end
  puts "User #{user.id} generated"
}