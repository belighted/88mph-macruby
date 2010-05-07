require 'AppDelegate'

class StatusBarController
  def update(statusbar)
    @statusbar ||= statusbar
    
    menu = NSMenu.new
    @statusbar.setMenu menu
    App.model.projects.each { |project, current|
      menu_item = NSMenuItem.new.initWithTitle project, action: "select_project:", keyEquivalent: ''
      menu_item.setState NSOnState if current
      menu_item.setTarget self
      menu.addItem menu_item
    }

    # separator
    menu.addItem NSMenuItem.separatorItem
    
    # Settings
    menu_item = NSMenuItem.new.initWithTitle "Preferences...", action: "settings:", keyEquivalent: ','
    menu_item.setTarget self
    menu.addItem menu_item
	
	# separator
    menu.addItem NSMenuItem.separatorItem
    
    # quit
    menu_item = menu.addItemWithTitle "Quit", action: "terminate:", keyEquivalent: 'q'
    menu_item.setKeyEquivalentModifierMask NSCommandKeyMask
    menu_item.setTarget NSApp
  end
  
  def select_project(sender)
    project_name = sender.title.to_s
    App.model.update_project project_name
    update @statusbar
  end
  
  def settings(sender)
	AppDelegate.sharedInstance.changePreferences(self)
  end
end