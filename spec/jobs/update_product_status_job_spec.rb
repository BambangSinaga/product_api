RSpec.describe UpdateProductStatusJob, type: :job do
  include ActiveJob::TestHelper
  let!(:product) { FactoryBot.create(:product) }

  it "Register Job queue" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      described_class.perform_later(product.id)
    }.to have_enqueued_job.on_queue('default')
  end

  describe '#perform' do
    it 'sends email to the given product' do
      expect(ProductMailer).to receive_message_chain(:add_product_success, :deliver_later).with(product.id).with(no_args)

      perform_enqueued_jobs { described_class.perform_now(product.id) }
    end
  end
end