class AddTitleToWebdata < ActiveRecord::Migration[5.0]
  def change
    add_column :webdata, :title, :text, :after => :url
  end
end
