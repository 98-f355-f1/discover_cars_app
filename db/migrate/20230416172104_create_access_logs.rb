class CreateAccessLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :access_logs do |t|
      t.string :ip_address
      t.string :method
      t.string :url_path
      t.string :user_agent

      t.timestamps
    end
  end
end
