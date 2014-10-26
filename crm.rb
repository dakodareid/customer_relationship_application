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
		puts "-------------------------"
		puts "[1] Add a contact"
		puts "[2] Modify a contact"
		puts "[3] Display all contacts"
		puts "[4] Display one contact"
		puts "[5] Display an attribute"
		puts "[6] Delete a contact"
		puts "[7] Exit"
		puts "-------------------------"
		puts  #<-- skip a line, for readability purposes only
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
			"[#{index.to_s}] FIRST NAME: #{contact.first_name}   LAST NAME: #{contact.last_name}   EMAIL: #{contact.email}   NOTE: #{contact.note}"
		end
		puts contacts_list

		selected = gets.chomp.to_i
		puts "NEW FIRST NAME:"
		new_first_name = gets.chomp
		@rolodex.update_first_name(selected, new_first_name)

		puts "NEW LAST NAME:"
		new_last_name = gets.chomp
		@rolodex.update_last_name(selected, new_last_name)

		puts "NEW EMAIL ADDRESS:"
		new_email_name = gets.chomp
		@rolodex.update_email_name(selected, new_email_name)
		
		puts "NEW NOTE ADDRESS:"
		new_note_name = gets.chomp
		@rolodex.update_note_name(selected, new_note_name)
		
	end

	def delete_contact
		
		puts "Choose the ID of the contact you wish to delete:"
		
		@rolodex.contacts.each do |contact|
			puts "FIRST NAME: #{contact.first_name}, LAST NAME: #{contact.last_name}, EMAIL: #{contact.email}, NOTE: #{contact.note},  ID: #{contact.id}"
		end

		who_to_delete = gets.chomp.to_i

		@rolodex.contacts.each do |contact|

			if contact.id == who_to_delete
				@rolodex.contacts.delete(contact)
				puts "#{who_to_delete} HAS BEEN DELETED!"
			else
				puts "Sorry, Can't find that person."
			end

		end

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

		contact = Contact.new(firstname, lastname, email, note)
		@rolodex.add_contact(contact)
	end

	def display_all_contacts
		@rolodex.contacts.each do |contact|
			puts "FIRST NAME: #{contact.first_name}, LAST NAME: #{contact.last_name}, EMAIL: #{contact.email}, NOTE: #{contact.note}"
		end
	end

	def display_contact
		
		puts "Who are you looking for"

		specific_contact = gets.chomp

		search = @rolodex.get_by_name(specific_contact)

		if !search.empty?
			puts "Searches matching #{specific_contact} are:"
			search.each do |contact|
				puts "FIRST NAME: #{contact.first_name}, LAST NAME: #{contact.last_name}, EMAIL: #{contact.email}, NOTE: #{contact.note}"
			end
		else
			puts "Can't find that contact."
		end
	end

end

crm = CRM.new("Dakoda's CRM")
crm.main_menu