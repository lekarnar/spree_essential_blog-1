class Spree::Blogs::Admin::PostsController < Spree::Admin::ResourceController

  # def index
  #   binding.pry
  #   @pages = collection
  # end

  def new
    @object = Spree::Post.new
    @object.posted_at ||= Time.now
  end

  def edit
    @object = Spree::Post.find_by_path(params[:id])
  end

  protected

    def model_class
      Spree::Post
    end

    def permitted_resource_params
      @permitted_resource_params ||= params.require('post').permit(:blog_id, :title, :posted_at, :body, :tag_list, :products_title, :link_title, :expires_at, :live, post_category_ids: [])
    end

  private

    update.before :set_category_ids

    def set_category_ids
      if params[:post] && params[:post][:post_category_ids].is_a?(Array)
        params[:post][:post_category_ids].reject!{|i| i.to_i == 0 }
      end
    end

    def location_after_save
      path = params[:redirect_to].to_s.strip.sub(/^\/+/, "/")
      path.blank? ? admin_posts_url : path
    end

    def find_resource
	  	@object ||= Spree::Post.find_by_path(params[:id])
    end

    def collection
      params[:q] ||= {}
      params[:q][:s] ||= "posted_at desc"
      @search = Spree::Post.ransack(params[:q])
      @collection = @search.result.page(params[:page]).per(Spree::Post.per_page)
    end

end
