class Tutorial < ApplicationRecord
  validates :title, presence: true
  validates :thumbnail, presence: true
  has_many :videos, -> { order(position: :ASC) }, inverse_of: :tutorial,
                                                  dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def toggle_classroom
    classroom? ? (self.classroom = false) : (self.classroom = true)
  end
end
