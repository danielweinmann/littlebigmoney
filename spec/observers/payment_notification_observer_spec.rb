require 'spec_helper'

describe PaymentNotificationObserver do
  describe 'before_save' do
    before do
      Notification.unstub(:create_notification)
      Notification.unstub(:create_notification_once)
      create(:notification_type, name: 'processing_payment')
    end

    context "when payment is being processed with transactionState" do
      before do
        Notification.should_receive(:create_notification_once)
        p = create(:payment_notification)
        p.extra_data = {'transactionState' => '7'}
        p.backer.project = create(:project)
        p.save!
      end
      it("should notify the backer"){ p }
    end

    context "when payment is being processed with state_pol" do
      before do
        Notification.should_receive(:create_notification_once)
        p = create(:payment_notification)
        p.extra_data = {'state_pol' => '7'}
        p.backer.project = create(:project)
        p.save!
      end
      it("should notify the backer"){ p }
    end

    context "when payment is approved with transactionState" do
      before do
        Notification.should_receive(:create_notification_once).never
        p = create(:payment_notification)
        p.extra_data = {'transactionState' => '4'}
        p.backer.project = create(:project)
        p.save!
      end
      it("should not notify the backer"){ p }
    end

    context "when payment is approved with state_pol" do
      before do
        Notification.should_receive(:create_notification_once).never
        p = create(:payment_notification)
        p.extra_data = {'state_pol' => '4'}
        p.backer.project = create(:project)
        p.save!
      end
      it("should not notify the backer"){ p }
    end

  end
end
