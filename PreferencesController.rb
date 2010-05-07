class PreferencesController < NSWindowController
	attr_accessor :window
	attr_writer :user_input
	attr_writer :pass_input
	attr_writer :ok_button
	attr_reader :ok_button
	
	def awakeFromNib
		puts "#{self.class} awoken!"
	end
	
	def	ok_button_clicked(sender)
		App.model.user = @user_input.stringValue
		App.model.pass =  @pass_input.stringValue
		puts "Settings saved !"
		@window.close
	end
end

