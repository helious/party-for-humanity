class Hash

	def encode_values_for_urls
		self.each { |k, v| self[k] = v.encode_for_urls if v.is_a? String }
	end

end