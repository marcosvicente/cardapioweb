require 'rails_helper'

RSpec.describe GetOpenRestaurantService, type: :service do
    # segunda à sexta das 10h às 17h e de sábado à domingo das 12h às 20h

  describe "Generate time to open restaurant" do
    context "success" do
      let!(:restaurant) { create(:restaurant) }
      context "in week" do
        it "should be return Aberto" do
          klass1 = described_class.new(restaurant_id: restaurant.id, times_open: "10h", day_of_week: "segunda").call
          klass2 = described_class.new(restaurant_id: restaurant.id, times_open: "17h", day_of_week: "sexta").call
          klass3 = described_class.new(restaurant_id: restaurant.id, times_open: "12h", day_of_week: "quinta").call

          expect(klass1.result).to eq("Aberto")
          expect(klass2.result).to eq("Aberto")
          expect(klass3.result).to eq("Aberto")
        end
     

        it "should be return Fechado" do
          klass1 = described_class.new(restaurant_id: restaurant.id, times_open: "23h", day_of_week: "quarta").call
          klass2 = described_class.new(restaurant_id: restaurant.id, times_open: "18h", day_of_week: "terça").call
          klass3 = described_class.new(restaurant_id: restaurant.id, times_open: "9h", day_of_week: "segunda").call

          expect(klass1.result).to eq("Fechado")
          expect(klass2.result).to eq("Fechado")
          expect(klass3.result).to eq("Fechado")
        end
      end
      context "in endweek" do
        it "should be return Aberto" do
          klass1 = described_class.new(restaurant_id: restaurant.id, times_open: "12h", day_of_week: "domingo").call
          klass2 = described_class.new(restaurant_id: restaurant.id, times_open: "14h", day_of_week: "sábado").call
          klass3 = described_class.new(restaurant_id: restaurant.id, times_open: "20h", day_of_week: "sábado").call

          expect(klass1.result).to eq("Aberto")
          expect(klass2.result).to eq("Aberto")
          expect(klass3.result).to eq("Aberto")
        end

        it "should be return Fechado" do
          klass1 = described_class.new(restaurant_id: restaurant.id, times_open: "11h", day_of_week: "sábado").call
          klass2 = described_class.new(restaurant_id: restaurant.id, times_open: "21h", day_of_week: "sábado").call
          klass3 = described_class.new(restaurant_id: restaurant.id, times_open: "23h", day_of_week: "sábado").call

          expect(klass1.result).to eq("Fechado")
          expect(klass2.result).to eq("Fechado")
          expect(klass3.result).to eq("Fechado")
        end
      end
    end

    context "fail" do
      let!(:restaurant) { create(:restaurant) }

      it "should be return error day_of_week not valid" do
        klass = described_class.new(restaurant_id: restaurant.id, times_open: "23h", day_of_week: "test").call

        expect(klass.errors.full_messages).to include("Day of week parametro não e valido")
      end
    end
  end
end