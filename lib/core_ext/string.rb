class String

  def encode_for_urls
    self.blank? ? nil : CGI.escape(self)
  end

  def decode_from_urls
    self.blank? ? nil : CGI.unescape(self)
  end

end