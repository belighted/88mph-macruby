class App
	def	self.model
		@@model
	end
	
	def	self.settings
		@@settings
	end

	def initialize
		@@model = Model.new
		StatusBar.new
	end
end

