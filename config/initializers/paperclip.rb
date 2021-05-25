Paperclip::Attachment.default_options[:storage] = :gcs
Paperclip::Attachment.default_options[:gcs_bucket] = ENV["GCS_BUCKET"]
Paperclip::Attachment.default_options[:url] = ":gcs_path_url"
Paperclip::Attachment.default_options[:path] = ":class/:attachment/:parent_id/:id/:style/:filename"
Paperclip::Attachment.default_options[:gcs_permissions] = :public_read
Paperclip::Attachment.default_options[:gcs_credentials] = {
    project: ENV["GCS_PROJECT"],
    # keyfile: ENV["GOOGLE_CLOUD_KEYFILE_JSON"],
}