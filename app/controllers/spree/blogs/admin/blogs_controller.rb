class Spree::Blogs::Admin::BlogsController < Spree::Admin::ResourceController

  def new
    @object = Spree::Blog.new
  end

  def show
    redirect_to admin_blogs_path
  end

  def edit
    @object = Spree::Blog.find_by_permalink(params[:id])
  end

  protected
    def model_class
      Spree::Blog
    end

    def permitted_resource_params
      @permitted_resource_params ||= params.require('blog').permit(:name, :permalink)
    end

private

  def find_resource
    Spree::Blog.find_by_permalink!(params[:id])
  end

  def collection
    params[:q] ||= {}
    params[:q][:meta_sort] ||= "name.asc"
    @search = Spree::Blog.search(params[:q])
    @collection = @search.result.page(params[:page]).per(Spree::Config[:orders_per_page])
  end

end
