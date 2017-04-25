module Features
  module User
    module SessionHelpers
      def sign_up_with form_data
        visit "/"
        click_link "Login"
        click_link "User Registration"
        fill_in 'user_first_name', :with => form_data[:first_name]
        fill_in 'user_last_name', :with => form_data[:last_name]
        fill_in 'user_email', :with => form_data[:email]
      	fill_in 'user_password', :with => form_data[:password]
      	fill_in 'user_password_confirmation', :with => form_data[:password]
      	click_button 'Sign up'
      end

      def sign_in user
        visit "/"
        click_link "Login"

      	fill_in 'user_email', :with => user.email
      	fill_in 'user_password', :with => user.password
      	click_button 'Login'
      end

      def user_sign_in user
        visit "/"
        click_link "Login"

      	fill_in 'user_email', :with => user.email
      	fill_in 'user_password', :with => user.password
      	click_button 'Login'
      end
    end
  end
end
