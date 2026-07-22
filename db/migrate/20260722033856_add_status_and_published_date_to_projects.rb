class AddStatusAndPublishedDateToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :status, :integer, default: 1, null: false
    add_column :projects, :published_date, :datetime
  end
end
