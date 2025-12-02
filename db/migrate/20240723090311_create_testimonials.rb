class CreateTestimonials < ActiveRecord::Migration[7.1]
  def change
    create_table :testimonials do |t|
      t.string :full_name, null: false, default: ""
      t.string :comment, null: false, default: ""
    end
  end
end
