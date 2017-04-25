module Features
  module Admin
    module ProductHelpers
      def create_product_with data
        click_link 'New Product'
        fill_in 'product_name', :with => data[:name]
        fill_in 'product_description', :with => data[:description]
        fill_in 'product_price', :with => data[:price]
        fill_in 'product_quantity', :with => data[:quantity]
        fill_in 'product_maker', :with => data[:maker]
        click_button 'Create Product'
      end
    end
  end
end
