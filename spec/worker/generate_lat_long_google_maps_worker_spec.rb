require 'rails_helper'

RSpec.describe GenerateLatLongGoogleMapsWorker, type: :worker do
  let!(:restaurant) { create(:restaurant, address: "Londrina") }
  it "should be validate if save a lat e long" do
    described_class.new.perform(restaurant.id)
    restaurant.reload
    expect(restaurant.lat).to eq(-23.3197305)
    expect(restaurant.long).to eq(-51.1662008)

  end
  it 'worker is enqueued in the default queue' do
    expect(described_class).to receive(:perform_async).once
    described_class.perform_async
    expect(described_class.queue.to_sym).to eq(:default)
  end

  it 'goes into the jobs array for testing environment' do
    expect do
      described_class.perform_async
    end.to change(described_class.jobs, :size).by(1)
  end

  it 'has a enqueued worker' do
    job = described_class.perform_async
    expect(described_class.jobs.last['jid']).to include(job)
  end
end