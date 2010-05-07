class AppController
	def awakeFromNib
		puts "#{self.class} awoken!"
		App.new
	end
end
