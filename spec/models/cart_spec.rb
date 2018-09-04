require 'rails_helper'

# RSpec.describe Cart, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe Cart do
	it "has a valid factory" do
		expect(build(:cart)).to be_valid
	end

	it "deletes line_items when deleted" do
		cart = create(:cart)
		food1 = create(:food)
		food2 = create(:food)

		line_item1 = create(:line_item, cart: cart, food: food1)
		line_item2 = create(:line_item, cart: cart, food: food2)
		cart.line_items << line_item1
		cart.line_items << line_item2

		expect { cart.destroy }.to change { LineItem.count }.by(-2)
	end
end
