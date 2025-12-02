module AdminHelper

  def blank_or_not(object,blank='-')
    if object.blank?
      blank
    else
      if block_given?
        yield
      else
        object
      end
    end
  end

	def flash_message
    message = ""
    flash.each do |name, msg|
			message += content_tag :div, :class => "alert alert-#{name.to_sym == :notice ? 'success' : 'danger'} alert-dismissible alert-label-icon label-arrow fade show" do
				lbl = if name.to_sym == :notice
					content_tag(:i, nil, class: "ri-notification-off-line label-icon") + content_tag(:strong, "Success")
				else
					content_tag(:i, nil, class: "ri-error-warning-line label-icon") + content_tag(:strong, "Danger")
				end
				lbl += " - #{msg}"
				lbl += content_tag(:button, nil, class: "btn-close", "data-bs-dismiss": "alert", "aria-label": "Close")
			end unless msg == true
    end
    message.html_safe
  end

	def flash_message2
    message = ""
    flash.each do |name, msg|
			message += content_tag :div, :class => "alert alert-#{name.to_sym == :notice ? 'success' : 'danger'} alert-dismissible alert-label-icon label-arrow fade show" do
				lbl = raw(msg)
				lbl += content_tag(:button, nil, class: "btn-close", "data-bs-dismiss": "alert", "aria-label": "Close") do
					content_tag(:i, nil, class: "fa-solid fa-close text-white-2")
				end
			end unless msg == true
    end
		flash.discard
    message.html_safe
  end

	def get_input_date_value(field, format='%d/%m/%Y %H:%M')
		field.nil? ? '' : field.strftime(format)
	end

	def sortable(column, title = nil)
    title ||= column
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_tag = link_to title.titleize, params.merge(:sort => column, :direction => direction, :page => nil)
    icon_tag = column == params[:sort] ? "&nbsp;<i class='#{direction == "asc" ? "icon-arrow-up" : "icon-arrow-down"}'></i>" : ""
    link_tag + icon_tag.html_safe
  end

	def empty_data_message(model, new_link)
		raw("Currently there are no data #{model.model_name.human.pluralize.downcase} at the moment. Please create one by clicking #{link_to "here", new_link}.")
	end

	def title_page(page_title)
    content_for(:title) do
			content_tag(:div, :class => "row") do
				content_tag(:div, :class => "col-12") do
					content_tag(:div, :class => "page-title-box d-sm-flex align-items-center justify-content-between") do
						content_tag(:h4, page_title, :class => "mb-sm-0")
					end
				end
			end
		end
  end

	def current_path?(*path)
		re = Regexp.union(path)
		return 'active' if request.path.match(re)
		''
  end

	def get_published_status
		[[0, 'Draft'], [1, 'Published']]
	end

	def populate_array_of_time
		["06:00",
		"07:00",
		"08:00",
		"09:00",
		"10:00",
		"11:00",
		"12:00",
		"13:00",
		"14:00",
		"15:00",
		"16:00",
		"17:00",
		"18:00",
		"19:00",
		"20:00",
		"21:00",
		"22:00",
		"23:00",
		"00:00",
		"01:00",
		"02:00",
		"03:00",
		"04:00",
		"05:00"]
	end

	def has_asset?(path)
		(Rails.application.assets || ::Sprockets::Railtie.build_environment(Rails.application)).find_asset(path) != nil
	end

	def replace_non_break(title)
		return title.gsub(/<br\/>/,' ')
	end

	# <span class="badge bg-primary">Primary</span>
	def badge_true_false_status(val, txt=nil)
		content_tag(:span, txt || val.to_s, class: "badge bg-#{val == 1 ? 'primary' : 'danger'}")
	end

	def is_admins_dashboard_page?
		controller.controller_name == "dashboard"
	end

  def is_admins_articles_page?
		controller.controller_name == "articles" ||
		controller.controller_name == "events" ||
    controller.controller_name == "categories"
  end

	def is_admins_users_page?
		controller.controller_name == "admins"
	end

  def is_admins_others_page?
		controller.controller_name == "features" ||
		controller.controller_name == "products" ||
		controller.controller_name == "projects" ||
		controller.controller_name == "questions" ||
		controller.controller_name == "testimonials" ||
		controller.controller_name == "contacts"
	end

end
