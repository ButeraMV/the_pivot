require 'rails_helper'

describe "Visitor can log in and see logged in options in cart" do
	context "visitor can see cart but cannot checkout" do
		scenario "Visitor can login as auth user and see checkout option" do
      Role.create(name: "registered")
			user = create(:user)
			category = create(:category)
	    item = create(:item, category: category)
	    item2 = create(:item, category: category)

	    visit '/items'

	    within(".index_item_#{item.id}") do
      	click_on "Add to Cart"
    	end

    	within(".index_item_#{item2.id}") do
      	click_on "Add to Cart"
    	end

			visit cart_path

			within(".cart_checkout") do
				expect(page).to have_content("Login or Create Account to Checkout")
				expect(page).to have_content("Checkout", count: 1)
			end

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

			visit cart_path

			within(".cart_checkout") do
				expect(page).to_not have_content("Login or Create Account to Checkout")
				expect(page).to have_content("Checkout", count: 1)
			end
		end
	end
end
