class Hash
  # deep_merge by Stefan Rusterholz, see <http://www.ruby-forum.com/topic/142809>.
  MERGER = proc do |key, v1, v2|
    Hash === v1 && Hash === v2 ? v1.merge(v2, &MERGER) : v2
  end

  def deep_merge(hash) # :nodoc:
    self.merge(hash, &MERGER)
  end

  def deep_merge!(hash) # :nodoc:
    self.merge!(hash, &MERGER)
  end
end
