require 'autostyle/version'
require 'insensitive_hash'

class Autostyle < InsensitiveHash
  def [](key)
    super(key) || self[key] = Autostyle.new
  end

  def to_s
    render
  end

  def render(master_key = '')
    self.map{ |k, v|
      key = [master_key, k].reject(&:empty?).join('-')
      next v.render(key) if v.is_a?(Autostyle)
      [key, v].join(': ')
    }.join('; ')
  end
end
