module Features
  module Admin
    module SessionHelpers
      def sign_up_with form_data
        visit "/admins/sign_in"
        click_link "Admin Registration"
        fill_in 'admin_first_name', :with => form_data[:first_name]
        fill_in 'admin_last_name', :with => form_data[:last_name]
        fill_in 'admin_email', :with => form_data[:email]
      	fill_in 'admin_password', :with => form_data[:password]
      	fill_in 'admin_password_confirmation', :with => form_data[:password]
      	click_button 'Sign up'
      end

      def sign_in admin
        visit "/admins/sign_in"

      	fill_in 'admin_email', :with => admin.email
      	fill_in 'admin_password', :with => admin.password
      	click_button 'Login'
      end

      def admin_sign_in admin
        visit "/admins/sign_in"

      	fill_in 'admin_email', :with => admin.email
      	fill_in 'admin_password', :with => admin.password
      	click_button 'Login'
      end
    end
  end
end
