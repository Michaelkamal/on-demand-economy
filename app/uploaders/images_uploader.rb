class ImagesUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog
  @@i = 0

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end



  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # override default imageuploader url 
  def url
     if model.class.to_s.underscore=='order'
       model_image='images'
     elsif model.class.to_s.underscore=='user'
      model_image='avatar'
    elsif model.class.to_s.underscore=='provider'
      model_image='image'
    elsif model.class.to_s.underscore=='payment'
      model_image='image'
     end
     
    x = "#{Rails.application.secrets.base_url}/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}/#{model[model_image][@@i]}"
    @@i=@@i+1
    if ("#{model[model_image][@@i]}" == "") 
      @@i = 0
    end
    x
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  #For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
