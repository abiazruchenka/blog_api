class CreateLoginIps < ActiveRecord::Migration[5.1]
  def change
    create_table :login_ips do |t|
      t.string :login, limit: 32, null: false
      t.string :author_ip, null: false
      t.references :user, foreign_key: true
    end
    add_index :login_ips, [:user_id, :author_ip], unique: true
  end
end
