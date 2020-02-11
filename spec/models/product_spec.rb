require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(id: 5, name: "Sports Equipment")
      @product = Product.create(name: "Basketball", price_cents: 2300, quantity: 12, category: @category)
    end

    it "is a valid product with all fields filled" do
      expect(@product).to be_valid
    end

    it "is not a product with no name" do
      @product.name = nil
      expect(@product).to_not be_valid
    end  

    it "is not a product with no price" do
      @product.price_cents = nil
      expect(@product).to_not be_valid
    end   

    it "is not a product with no quantity" do
      @product.quantity = nil
      expect(@product).to_not be_valid
    end  

    it "is not a product with no category" do
      @product.category = nil
      expect(@product).to_not be_valid      
    end
  end
end