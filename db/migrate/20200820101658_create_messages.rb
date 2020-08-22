class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :user,foreign_key: true,null: false
      t.references :room,foreign_key: true,null: false
      t.text :message,limit: 300,null: false
      t.timestamps
    end
  end
end
