class Hash

	def encode
		self.each { |k, v| self[k] = v.encode if v.is_a? String }
	end

end