# frozen_string_literal: true

class FileBlob
  attr_reader :file_data_url

  def initialize(file_data_url)
    @file_data_url = file_data_url
  end

  def mime_type
    file_data_url[%r/(image|video)\/[a-z]{3,4}/]
  end

  def to_io
    StringIO.new(decoded_content)
  end

  private

  def decoded_content
    Base64.decode64(content)
  end

  def content
    file_data_url.sub(%r/data:(image|video)\/.{3,},/, '')
  end
end
