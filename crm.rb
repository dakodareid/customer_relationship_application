require_relative './contact.rb'
require_relative './rolodex.rb'
require "pry"

class CRM
	
	attr_accessor :name

	def initialize(name)
		@name = name #<--@name is the instance variable that lives anywhere within the class
		@rolodex = Rolodex.new
	end

	def print_main_menu
		puts "[1] Add a contact"
		puts "[2] Modify a contact"
		puts "[3] Display all contacts"
		puts "[4] Display one contact"
		puts "[5] Display an attribute"
		puts "[6] Delete a contact"
		puts "[7] Exit"
		puts " " #<-- skip a line, for readability purposes only
		puts "Enter a number:"
	end

	def main_menu
		puts "Welcome to #{@name}"

		while true
			puts " " #<-- skip a line, for readability purposes only
			print_main_menu
			input = gets.chomp.to_i
			return if input == 7
			choose_option(input)
		end
	end

	def choose_option(option)
		case option
		when 1 then add_contact
		when 2 then modify_contact
		when 3 then display_all_contacts
		when 4 then display_contact
		when 5 then display_attribute
		when 6 then delete_contact
		else 
			puts "Invalid option, try again!"
		end
	end

	def modify_contact
		puts "Choose a contact number to modify:"
		contacts_list = @rolodex.contacts.map.with_index do |contact, index|
			"#{index.to_s} #{contact.first_name} #{contact.last_name}"
		end
		puts contacts_list

		selected = gets.chomp
		puts "Choose a first_name:"
		@rolodex.contacts[selected].first_name = gets.chomp
		
		binding.pry
	end

	def add_contact
		print "First Name:"
		firstname = gets.chomp
		print "Last Name:"
		lastname = gets.chomp
		print "Email:"
		email = gets.chomp
		print "Note:"
		note = gets.chomp

		contact = Contact.new(firstname, lastname, contact, note)
		@rolodex.add_contact(contact)
	end

	def display_all_contacts
		@rolodex.contacts.each do |contact|
			puts "#{contact.first_name}, #{contact.last_name}, #{contact.email}, #{contact.note}"
			puts
		end
	end

	def display_contact
		
		puts "Who are you looking for"
		specific_contact = gets.chomp

		search = @rolodex.contacts.select do |contact| 
			contact.first_name.include?(specific_contact) || 
			contact.last_name.include?(specific_contact) 
		end

		if !search.empty?
			puts "Searches matching #{specific_contact} are:"
			search.each do |contact|
				puts "#{contact.first_name}, #{contact.last_name}, #{contact.email}, #{contact.note}"
			end
		else
			puts "Can't find that contact."
		end
	end


	# def display_contact
	# 	puts " Who are you looking for?"
	# 	specific_contact = gets.chomp
	# 	@rolodex.index {|contact| contact == "specific_contact"}
	# end

		# @rolodex.contacts(specific_contact)
		# puts "#{contact.first_name}, #{contact.last_name}, #{contact.email}, #{contact.note}"
end

crm = CRM.new("Dakoda's CRM")
crm.main_menu
