Deface::Override.new(:virtual_path  => "spree/products/index",
                     :name          => "add_blog_to_homepage",
                     :insert_bottom => "div[data-hook='homepage_products']",
                     :partial       => "spree/blogs/shared/preview",
                     :disabled      => false)
