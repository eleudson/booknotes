# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def show_tabs
    menu = ""
    tabs = [
            ['Home','home',['home']],
            ['Publication','publications',['publications','reviews','notes']],
            ['Author','authors',['authors']],
            ['Editor','editors',['editors']]
           ]
    tabs.each do |t|
      classe = t[2].include?(controller.controller_name) ? "class='active'" : ''
      page = eval  "#{t[1]}_path"
      menu << "<a href=\" #{page} \" #{classe}>#{t[0]}</a>"
    end
    menu
  end

  def publication_title
    "<p><%= h 'Publication: ' + @publication.title %></p>"
  end
end
