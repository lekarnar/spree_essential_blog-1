class Spree::Blogs::Admin::PostProductsController < Spree::Admin::BaseController

  before_filter :load_data

  def create
    position = @post.products.count
    @product = Spree::Product.find(params[:post_product][:product])
    Spree::PostProduct.create(:post_id => @post.id, :product_id => @product.id, :position => position)
    redirect_to :back
  end

  def destroy
    @related = Spree::PostProduct.find(params[:id])
    if @related.destroy
      render_js_for_destroy
    end
  end

  protected

    def model_class
      Spree::PostProduct
    end

  private

    def load_data
	  	@post = Spree::Post.find_by_path(params[:post_id])
    end

end
