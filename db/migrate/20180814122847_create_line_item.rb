class CreateLineItem < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :food, index: true, foreign_key: true
      t.belongs_to :cart, index: true, foreign_key: true
    end
  end
end
