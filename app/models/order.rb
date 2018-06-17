class Order < ApplicationRecord
    # serialize :images, Array
    paginates_per 3
    validates_presence_of :src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:title, :provider_id,:payment_method,:weight,:images
    mount_uploaders :images, ImagesUploader

end
