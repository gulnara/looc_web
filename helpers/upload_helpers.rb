module UploadHelpers

  def upload(filename, file)
    bucket = ENV['AWS_BUCKET']

    akid = ENV['AWS_ACCESS_KEY_ID']
    secret = ENV['AWS_SECRET_ACCESS_KEY']

    s3 = Aws::S3::Resource.new(
      credentials: Aws::Credentials.new(akid, secret),
      region: 'us-east-1'
    )

    key = Time.now.to_s.delete(' ')+filename
     
    obj = s3.bucket(bucket).object(key)
    obj.upload_file(file, acl:'public-read')

    return obj.public_url
  end
end