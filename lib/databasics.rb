require "active_record"
require "yaml"
require "pry"

require "databasics/version"
require "databasics/user"
require "databasics/address"
require "databasics/order"
require "databasics/item"

db_config = YAML.load(File.open("config/database.yml"))
ActiveRecord::Base.establish_connection(db_config)

module Databasics
	class App
		def add_user
			Puts "Enter First Name:"
			fname = gets.chomp.to_downcase
			Puts "Enter Last Name:"
			lname = gets.chomp.to_downcase
			puts "Enter Email Address:"
			email = gets.chomp.to_downcase
			user = User.new(first_name: first, last_name: last, email: email)
			user.save
			puts "Your user ID is #{user.id}"
		end

		def show_addresses
			puts "Enter First Name:"
			fname = gets.chomp.to_downcase
			puts "Enter Last Name:"
			lname = gets.chomp.to_downcase
			user = User.findby(first_name: first, last_name: last)
			address = Address.where(user_id: user.id)
			addresses.each do |address|
				puts "Address on record: #{address.street}, #{address.state}, #{address.city}, #{address.zip}"
			end
		end

		def show_orders
			puts "Enter User ID:"
			user_id = gets.chomp
			orders = Order.where(user_id: user.id)
			orders.each do |order|
				item = Item.find(order.item_id)
				puts "Orders on record: #{order.quantity} #{item.title.pluralize}"
			end
		end

		def create_new_order
			puts "Enter Item You Wish To Order:"
			iname = gets.chomp
			if Item.where ("title = #{iname}")
				item = Item.find_by(title: iname)
			else
				puts "Invalid item, Order Declined"
			end
			puts "Enter Order Quantity:"
			quantity = gets.chomp
			puts "Enter User ID:"
			user_id = gets.chomp
			new_order = Order.new(user_id: user_id, item_id: item.item_id, quantity: quantity, created_at: DateTime.now)
		end

	end
 
binding.pry

end

app = Databasics::App.new

binding.pry