module ResourceHelper
  
  def ical(calendar, resource)
    resource.events.each do |event|
      e               = Icalendar::Event.new
      e.uid           = event[:id]   
      e.dtstart       = event[:start]    
      e.dtend         = event[:end] 
      e.summary       = "Room booking for #{event[:title]}" 
      e.location      = resource.name  
      e.created       = event[:created]
      e.last_modified = event[:updated]
      calendar.add e
    end
    calendar.publish
    calendar.to_ical
  end
  
  def get_resources
    content = '''
    <div class="navbar navbar-static-top" id="mainnav">
				<div class="container">
					<div class="navbar-inner">
						<ul class="nav pull-right">
    '''
    Resource.where(:active => true).each do |res|
      content << "<li>"
      content << link_to(res.name, res)
      unless params[:action] == "index"
        if resource_url(res).match(/#{params[:id]}/)
          content << '<div class="arrow-down"></div>'
        end
      end
      content << "</li>"
    end
    content << '''
    			</ul>
				</div>
			</div>
		</div>
    '''
    concat(content.html_safe)
  end
  
end
