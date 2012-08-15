module ApplicationHelper

  def identifier
    if controller.env['PATH_INFO'] == "/"
      "root"
    else
      controller.env['PATH_INFO'].match(/^\/(\w+)/)[1]
    end
  end

end
