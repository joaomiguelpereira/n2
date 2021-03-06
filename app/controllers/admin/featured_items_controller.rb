class Admin::FeaturedItemsController < AdminController
  skip_before_filter :admin_user_required
  layout proc {|c| c.request.xhr? ? false : "new_admin" }
  before_filter :set_featured_types, :only => :load_template

  def index
  end

  def load_template
    return false unless params[:id] =~ /^template_[0-9]+$/

    @template_id = params[:id]
  end

  def load_items
    case params[:id]
      when Content.name.tableize
        @items = Content.paginate :page => params[:page], :per_page => 12, :order => "created_at desc"
      when Idea.name.tableize
        @items = Idea.paginate :page => params[:page], :per_page => 12, :order => "created_at desc"
      else
      	return false
    end
  end

  def save
    FeaturedItem.all.each {|fi| fi.destroy}

    data = ActiveSupport::JSON.decode(params['featured_items'])
    @template_name = FeaturedItem.create({:name => 'featured_template', :featured_type => data['template']})
    @section1 = @template_name.children.create({:name => "section1", :featured_type => "section1"})
    @section2 = @template_name.children.create({:name => "section2", :featured_type => "section2"})
    ['section1', 'section2'].each do |section|
      section_data = instance_variable_get("@#{section}")
      ['primary', 'secondary1', 'secondary2'].each do |box|
        item_id = data[section][box]
        next unless item = get_item(item_id)
        item = get_item item_id
        section_data.children.create({:name => "item_#{item_id}", :featured_type => "featured_item", :featurable => item})
      end
    end

    render :json => {:success => "Success!"}.to_json and return
  end

  private

  def get_item item
    return false unless item and item =~ /^([^_]+)_([0-9]+)$/
    case $1
      when 'content'
        return Content.find_by_id($2)
      when 'idea'
        return Idea.find_by_id($2)
      else
      	return false
    end
  end

  def set_featured_types
    @featurables ||= [['Stories', 'contents'], ['Ideas', 'ideas']]
  end

  def set_current_tab
    @current_tab = 'featured-items';
  end

end
