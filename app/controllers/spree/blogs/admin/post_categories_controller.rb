class Spree::Blogs::Admin::PostCategoriesController < Spree::Admin::ResourceController

  before_filter :load_data

  def new
    @object = Spree::PostCategory.new
  end

  def edit
    @object = Spree::PostCategory.find_by_id(params[:id])
  end

  protected

  def model_class
    Spree::PostCategory
  end

  def permitted_resource_params
    @permitted_resource_params ||= params.require('post_category').permit(:name, :permalink)
  end

  private

    def location_after_save
      admin_post_categories_url(@post)
    end

    def load_data
      @post = Spree::Post.find_by_path(params[:post_id])
      @post_categories = Spree::PostCategory.all
    end

end
