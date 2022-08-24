class Micropost < ApplicationRecord
  UPDATABLE_ATTRS = %i(content image).freeze

  belongs_to :user
  has_one_attached :image

  validates :user_id, presence: true
  validates :content, presence: true,
                      length: {maximum: Settings.micropost.max_content}
  validates :image, content_type: {in: Settings.micropost.content_type,
                                   message: :wrong_format},
         size:{less_than:
    Settings.micropost.file_size.megabytes,
                        message: :too_big}

  scope :recent_post, ->{order(created_at: :desc)}

  def display_image
    image.variant resize_to_limit: Settings.micropost.image_resize
  end
end
