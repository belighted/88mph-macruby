class StatusBar
  def initialize
    statusbar = NSStatusBar.systemStatusBar
    @status_item = statusbar.statusItemWithLength NSVariableStatusItemLength

	image = NSImage.imageNamed 'stretch'

    @status_item.setImage image
    @controller = StatusBarController.new
    @controller.update @status_item
  end
end