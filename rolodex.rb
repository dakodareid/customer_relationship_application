class Rolodex
	
	attr_reader :contacts
	
	@@index = 1000
	def initialize
		@contacts = []
	end

	def add_contact(contact)
		contact.id = @@index
		@@index += 1
		@contacts << contact
	end

	def get_by_name(specific_contact)
		@contacts.select do |contact| 
			contact.first_name.include?(specific_contact) || 
			contact.last_name.include?(specific_contact) 
		end
	end

	def update_first_name(this_contact_id, new_first_name)
		@contacts[this_contact_id].first_name = new_first_name
	end

	def update_last_name(this_contact_id, new_last_name)
		@contacts[this_contact_id].last_name = new_last_name
	end

	def update_email_name(this_contact_id, new_email_name)
		@contacts[this_contact_id].email = new_email_name
	end

	def update_note_name(this_contact_id, new_note_name)
		@contacts[this_contact_id].note = new_note_name
	end

end


