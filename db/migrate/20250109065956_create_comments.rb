class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true # userを参照する外部キー
      t.references :prototype, null: false, foreign_key: true # prototypeを参照する外部キー

      t.timestamps
    end
  end
end
