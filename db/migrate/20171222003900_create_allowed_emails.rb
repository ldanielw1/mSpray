class CreateAllowedEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :allowed_emails do |t|
      t.string :email
    end
  end
end
