require 'App'
require 'PreferencesController'

class AppDelegate
	def	self.sharedInstance
		@@instance
	end

	def applicationDidFinishLaunching(notification)
		@@instance = self
	end

	def	changePreferences(sender)
		c = NSWindowController.alloc.initWithWindowNibName("Preferences")
		c.showWindow(self)
		c.window.makeKeyWindow
	end
end
