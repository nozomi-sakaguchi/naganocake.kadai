class Order < ApplicationRecord

  belongs_to :customer
  has_many   :order_items

  enum payment_methods: { credit_card: 0, transfer: 1 }

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io:File.open(file_path),filename: 'default-image.jpg', content_type:'image/jpeg')
    end
    image.variant(resize_to_limit: [width,height]).processed
  end


end
