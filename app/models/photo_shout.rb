class PhotoShout < ApplicationRecord
  has_attached_file :image, styles: { thumb: "200X200" }

  validates_attachment :image,
                       content_type: { content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"] },
                       presence: true,
                       size: { in: 0..10.megabytes }
end
