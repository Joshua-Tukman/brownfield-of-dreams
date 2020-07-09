class UserVideo < ApplicationRecord
  belongs_to :video
  belongs_to :user

  def self.bookmarked_videos(user)
    order_bookmarks(collect_bookmarks(user))
  end

  def self.collect_bookmarks(user)
    user.videos.select(:title,
                       :id,
                       :position, 'tutorials.title AS tutorial_title',
                       'tutorials.id AS tutorial_id')
        .joins(:tutorial)
        .order(:tutorial_id, :position)
  end

  def self.order_bookmarks(bookmarks)
    bookmarks.group_by(&:tutorial_title)
  end
end
