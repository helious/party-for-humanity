class String

  def encode
    self.blank? ? nil : CGI.escape(self)
  end

  def decode
    self.blank? ? nil : CGI.unescape(self)
  end

end