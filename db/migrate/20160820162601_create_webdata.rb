class CreateWebdata < ActiveRecord::Migration[5.0]
  def change
    create_table :webdata do |t|
      t.string :url
      t.string :webdata

      t.timestamps
    end
  end
end
