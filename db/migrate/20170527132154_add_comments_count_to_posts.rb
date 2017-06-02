class AddCommentsCountToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :comments_count, :integer, null: false, default: 0

    if Rails.env.development?
      Post.pluck(:id).each do |post_id|
        Post.reset_counters(post_id, :comments)
      end
    end
  end
end
