class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :login, limit: 32, unique: true
      t.timestamps
    end
    add_index :users, :id
  end
end


