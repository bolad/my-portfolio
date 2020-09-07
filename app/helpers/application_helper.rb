module ApplicationHelper

  def login_helper style = ''
    if current_user.is_a?(GuestUser)
      (link_to "Sign Up", new_user_registration_path, class: style) + " ".html_safe +
      (link_to "Login", new_user_session_path, class: style)
    else
      link_to "Logout", destroy_user_session_path, method: :delete, class: style
    end
  end

  def source_helper(layout_name)
    if session[:source]
      greeting = "Thanks for visiting me from #{session[:source]} and you are on the #{layout_name} layout"
      content_tag(:p, greeting, class: "source-greeting")
    end
  end

  def copyright_generator
    @copyright = BoladViewTool::Renderer.copyright 'Stanley Akyea', 'All rights reserved'
  end

  def nav_items
   [
     {
       url: root_path,
       title: 'Home'
     },
     {
       url: about_me_path,
       title: 'About Me'
     },
     {
       url: contact_path,
       title: 'Contact'
     },
     {
       url: blogs_path,
       title: 'Blog'
     },
     {
       url: portfolios_path,
       title: 'Portfolio'
     },
   ]
 end

 def nav_helper style, tag_type
   nav_links = ''

   nav_items.each do |item|
     nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
   end

   nav_links.html_safe
 end

#return 'active' if current_page matches whatever path we pass in
 def active? path
   "active" if current_page? path
 end

def alerts
  alert = (flash[:alert] || flash[:notice] || flash[:error])
  if alert
    alert_generator(alert)
  end
end

def alert_generator(msg)
  js add_gritter(msg, title: "Stanley Akyea's Portfolio", sticky: false)
end

end
