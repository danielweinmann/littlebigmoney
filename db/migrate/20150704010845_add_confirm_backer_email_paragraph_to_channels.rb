class AddConfirmBackerEmailParagraphToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :confirm_backer_email_paragraph, :text
  end
end
