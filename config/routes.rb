class Spree::PossibleBlog
  def matches?(request)
    @locales ||= I18n.available_locales.map &:to_s
    components = request.path.gsub(/(^\/+)/, "").split('/')
    components.shift if @locales.include?(components.first)
    return false if components.first =~ Spree::Blog::RESERVED_PATHS
    permalink = components.first
    blog = Spree::Blog.find_by_permalink!(permalink) rescue nil
    blog.present?
  end
end

Spree::Core::Engine.add_routes do
  scope(:module => "blogs") do
    namespace :admin do
      resources :blogs, :constraints => { :id => /[a-z0-9\-\_\/]{3,}/ }

      resources :posts do
        resources :images, :controller => "post_images" do
          collection do
            post :update_positions
          end
        end
        resources :products, :controller => "post_products"
        resources :categories, :controller => "post_categories"
      end

      resource :disqus_settings

    end

    # PLZ is there a better way to do this?!
    constraints Spree::PossibleBlog.new do
      constraints(
        :year  => /\d{4}/,
        :month => /\d{1,2}/,
        :day   => /\d{1,2}/
      ) do
        get ":blog_id/:year(/:month(/:day))" => "posts#index", :as => :post_date
        get ":blog_id/:year/:month/:day/:id" => "posts#show",  :as => :full_post
      end
      get ":blog_id/category/:id"   => "post_categories#show", :as => :post_category, :constraints => { :id => /.*/ }
      get ":blog_id/search/:query"  => "posts#search",         :as => :search_posts, :query => /.*/
      get ":blog_id/archive"        => "posts#archive",        :as => :archive_posts
      get ":blog_id"                => "posts#index",          :as => :blog_posts
    end
  end
end
