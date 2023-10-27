require 'rails_helper'

RSpec.describe GenerateLatLongService, type: :service do
  describe "Generate lat long to restaurant" do
    context "success" do
      let!(:restaurant) { create(:restaurant, address: "Boituva") }
      let (:klass) { described_class.new(restaurant:).call }

      it "should be create lat" do
        expect(klass.result.lat).to eq(-23.2863329)

        restaurant.reload
        expect(restaurant.lat).to eq(-23.2863329)
      end
      
      it "should be create long" do
        expect(klass.result.long).to eq(-47.6783742)

        restaurant.reload
        expect(restaurant.long).to eq(-47.6783742)
      end
    end

    context "fail" do
      let!(:restaurant) { create(:restaurant, address: "belknbjernberkbelr") }
      let (:klass) { described_class.new(restaurant:).call }
      context "should be not create if not valid address" do
        it "with lat is 0" do
          restaurant.reload
          expect(restaurant.lat).to eq(0.0)
        end

        it "with long is 0" do
          restaurant.reload
          expect(restaurant.long).to eq(0.0)
        end

        it "render errors not find address" do
          expect(klass.errors.full_messages).to include("Não encontrado endereco")
        end
      end
    end
  end
end