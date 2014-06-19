module SpreeEssentials
  module Generators
    class BlogGenerator < Rails::Generators::Base
      
      desc "Installs required migrations for spree_essentials_blog"
      
      class_option :add_stylesheets, :type => :boolean, :default => true, :banner => "Append spree_essential_blog to store/all.css"
      
      def add_stylesheets
        inject_into_file "vendor/assets/stylesheets/spree/frontend/all.css", "*= require store/spree_essential_blog\n*/", :before => /\*\//, :verbose => true
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end

    end
  end
end
