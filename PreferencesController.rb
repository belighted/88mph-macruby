class PreferencesController < NSWindowController
	attr_accessor :window
	attr_writer :user_input
	attr_writer :pass_input
	attr_writer :ok_button
	attr_reader :ok_button
	
	def awakeFromNib
		puts "#{self.class} awoken!"
		@user_input.stringValue = NSUserDefaults.standardUserDefaults['user'] || "john.doe@example.com"
		@pass_input.stringValue = NSUserDefaults.standardUserDefaults['pass'] || "secret"
	end
	
	def	ok_button_clicked(sender)
		App.model.user = @user_input.stringValue
		App.model.pass =  @pass_input.stringValue
		NSUserDefaults.standardUserDefaults['user'] = @user_input.stringValue
		NSUserDefaults.standardUserDefaults['pass'] = @pass_input.stringValue
		NSUserDefaults.standardUserDefaults.synchronize
		puts "Settings saved"
		alert = NSAlert.new
		alert.setMessageText("You should restart the application for the changes to take effect. This sucks, I know.") # not enough time to do it right
		alert.runModal()
		NSApplication.sharedApplication.terminate(nil)
	end
end

