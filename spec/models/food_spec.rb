require 'rails_helper'

describe Food do
	it "has a valid factory" do
		#expect(FactoryGirl.build(:food)).to be_valid
		expect(build(:food)).to be_valid
	end

	it "is valid with a name and description" do
	    # food = Food.new(
	    #   name: "Nasi Uduk",
	    #   description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
	    #   price: 10000.0
	    # )
	    #expect(FactoryGirl.build(:food)).to be_valid
	    expect(build(:food)).to be_valid #--> bisa langsung tulis build karena sudah disederhanakan di rails_helper
	end

	it "is invalid without a name" do
	    # food = Food.new(
	    #   name: nil,
	    #   description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
	    #   price: 10000.0
	    # )
	    #food = FactoryGirl.build(:food, name: nil)
	    food = build(:food, name: nil)
	    food.valid?
	    expect(food.errors[:name]).to include("can't be blank")
	end

	it "is invalid without a description" do
	    # food = Food.new(
	    #   name: "Nasi Uduk",
	    #   description: nil,
	    #   price: 10000.0
	    # )
	    #food = FactoryGirl.build(:food, description: nil)
	    food = build(:food, description: nil)
	    food.valid?
	    expect(food.errors[:description]).to include("can't be blank")
	end

	it "is invalid with a duplicate name" do
	    # food1 = Food.create(
	    #   name: "Nasi Uduk",
	    #   description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
	    #   price: 10000.0
	    # )

	    # food2 = Food.new(
	    #   name: "Nasi Uduk",
	    #   description: "Just with a different description.",
	    #   price: 10000.0
	    # )

	    #food1 = FactoryGirl.create(:food, name: "Nasi Uduk") #food new dan save
	    #food2 = FactoryGirl.build(:food, name: "Nasi Uduk") #food new doang, ga save database
	    food1 = create(:food, name: "Nasi Uduk") 
	    food2 = build(:food, name: "Nasi Uduk")

	    food2.valid?
	    expect(food2.errors[:name]).to include("has already been taken")
	end

	it "returns a sorted array of results that match" do
	    food1 = Food.create(
	      name: "Nasi Uduk",
	      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
	      price: 10000.0
	    )

	    food2 = Food.create(
	      name: "Kerak Telor",
	      description: "Betawi traditional spicy omelette made from glutinous rice cooked with egg and served with serundeng.",
	      price: 8000.0
	    )

	    food3 = Food.create(
	      name: "Nasi Semur Jengkol",
	      description: "Based on dongfruit, this menu promises a unique and delicious taste with a small hint of bitterness.",
	      price: 8000.0
	    )

	    expect(Food.by_letter("N")).to eq([food3, food1])
	end

	it "omits results that do not match" do
	    food1 = Food.create(
	      name: "Nasi Uduk",
	      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
	      price: 10000.0
	    )

	    food2 = Food.create(
	      name: "Kerak Telor",
	      description: "Betawi traditional spicy omelette made from glutinous rice cooked with egg and served with serundeng.",
	      price: 8000.0
	    )

	    food3 = Food.create(
	      name: "Nasi Semur Jengkol",
	      description: "Based on dongfruit, this menu promises a unique and delicious taste with a small hint of bitterness.",
	      price: 8000.0
	    )

	    expect(Food.by_letter("N")).not_to include(food2)
	end

	describe "filter name by letter" do
	    before :each do
	    	@food1 = Food.create(
	        	name: "Nasi Uduk",
	        	description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
	        	price: 10000.0
	      	)

	      	@food2 = Food.create(
	        	name: "Kerak Telor",
	        	description: "Betawi traditional spicy omelette made from glutinous rice cooked with egg and served with serundeng.",
	        	price: 8000.0
	      	)

	      	@food3 = Food.create(
	        	name: "Nasi Semur Jengkol",
	        	description: "Based on dongfruit, this menu promises a unique and delicious taste with a small hint of bitterness.",
	        	price: 8000.0
	      	)
	    end

	    context "with matching letters" do
	      	it "returns a sorted array of results that match" do
	        	expect(Food.by_letter("N")).to eq([@food3, @food1])
	      	end
	    end

	    context "with non-matching letters" do
	      	it "omits results that do not match" do
	        	expect(Food.by_letter("N")).not_to include(@food2)
	      	end
	    end
	end

	#Exercise
	#1a
	it "is valid with numeric price greater or equal to 0.01" do
    	expect(build(:food, price: 0.01)).to be_valid
  	end

  	it "is invalid without numeric price" do
    	food = build(:food, price: "")
    	food.valid?
    	expect(food.errors[:price]).to include("is not a number")
  	end

  	it "is invalid with price less than 0.01" do
    	food = build(:food, price: -10)
    	food.valid?
    	expect(food.errors[:price]).to include("must be greater than or equal to 0.01")
  	end

  	#1b
  	it "is valid with image_url ending with '.gif', '.jpg', or '.png'" do
    	expect(build(:food, image_url: "food.jpg")).to be_valid
  	end

  	it "is invalid with image_url ending not with '.gif', '.jpg', or '.png'" do
    	food = build(:food, image_url: "food.csv")
    	food.valid?
    	expect(food.errors[:image_url]).to include("must be a URL for GIF, JPG, or PNG image.")
  	end

  	#2
  	describe "filter name by letter" do
    	before :each do
      		@food1 = create(:food, name: "Nasi Uduk")
      		@food2 = create(:food, name: "Kerak Telor")
      		@food3 = create(:food, name: "Nasi Semur Jengkol")
    	end

    	context "with matching letters" do
      		it "returns a sorted array of results that match" do
        		expect(Food.by_letter("N")).to eq([@food3, @food1])
      		end
		end

		context "with non-matching letters" do
      		it "omits results that do not match" do
        		expect(Food.by_letter("N")).not_to include(@food2)
      		end
		end
	end

	it "can't be destroyed while it has line_item(s)" do
		cart = create(:cart)
		food = create(:food)

		line_item = create(:line_item, cart: cart, food: food)
		food.line_items << line_item

		expect { food.destroy }.not_to change(Food, :count)
	end
end
