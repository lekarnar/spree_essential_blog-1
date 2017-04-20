class Spree::Blogs::Admin::PostImagesController < Spree::Admin::ResourceController

  before_filter :load_data

  create.before :set_viewable
  update.before :set_viewable
  destroy.before :destroy_before

  def new
    @object = Spree::PostImage.new
  end

  def edit
    @object = Spree::PostImage.find_by_id(params[:id])
  end

  def update_positions
    params[:positions].each do |id, index|
      Spree::PostImage.update_all(['position=?', index], ['id=?', id])
    end

    respond_to do |format|
      format.js  { render :text => 'Ok' }
    end
  end

  protected

    def model_class
      Spree::PostImage
    end

    def permitted_resource_params
      @permitted_resource_params ||= params.require('post_image').permit(:attachment, :alt)
    end

  private

    def location_after_save
      admin_post_images_url(@post)
    end

    def load_data
      @post = Spree::Post.find_by_path(params[:post_id])
    end

    def set_viewable
      @object.viewable = @post
    end

    def destroy_before
      @viewable = @object.viewable
    end

end
