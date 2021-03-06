class HomeController < ApplicationController
  caches_page :index, :google_ads, :bookmarklet_panel

  before_filter :set_current_tab

  def index
    #expires_in 1.minutes, :private => false, :public => true
    @no_paginate = true
  end

  def app_tab
    @no_paginate = true
    @contents = Content.find(:all, :limit => 10, :order => "created_at desc")
  end

  def google_ads
    render :partial => 'shared/google_ads.html.haml', :layout => false
  end

  def bookmarklet_panel
    render :partial => 'shared/bookmarklet_panel.html.haml', :layout => false
  end

  def about
  end

  def faq
  end

  def terms
  end

  def contact_us
    if request.post?
    	@message = Message.new(params[:message])
    	@message.user = current_user if current_user.present?

    	if @message.save
    		flash[:notice] = "Thank you for contacting us, your input is appreciated."
    		redirect_to root_path
    	else
    		flash[:error] = "There was an error while processing your request. Please try again."
    	end
    else
    	@message = Message.new
    	@message.email = current_user.email if current_user.present? and current_user.email.present?
    end
  end

  def test_widgets
    @featured_items = FeaturedItem.find_root_by_item_name('featured_template')
    controller = self
    @page = WidgetPage.find_root_by_page_name('home')
    @main = @page.children.first.children
    @sidebar = @page.children.second.children
    @main.each {|w| controller.send(w.widget.load_functions) if w.widget.load_functions.present? }
    @sidebar.each {|w| controller.send(w.widget.load_functions) if w.widget.load_functions.present? }
  end

  def render_widget
    @no_paginate = true
    controller = self
    @widget = Widget.find_by_id(params[:id])
    controller.send @widget.load_functions if @widget.load_functions.present?
    locals = @widget.locals.present? ? { @widget.locals.to_sym => instance_variable_get("@#{@widget.locals}") } : {}

    render :partial => @widget.partial, :locals => locals and return
  end

  private

  def set_current_tab
    @current_tab = 'home'
  end

end
