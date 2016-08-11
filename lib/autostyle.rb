require 'autostyle/version'
require 'insensitive_hash'

class Autostyle < InsensitiveHash
  def self.[](hash)
    self.new.tap{ |a| hash.each{ |k, v| a[k] = v } }
  end

  def [](key)
    super(key) || self[key] = Autostyle.new
  end

  def []=(key, value)
    return super(key, value) if key.empty?
    return super(key, value) if value.is_a?(Autostyle)
    super(key, stylize(value))
  end

  def merge!(hash)
    hash.each do |k, v|
      next self[k] = v if k.empty?
      self[k].merge!(stylize(v))
    end
  end

  def dup
    Autostyle.new.tap do |a|
      each do |k, v|
        a[k] = v.is_a?(Hash) ? v.dup : v
      end
    end
  end

  def merge(hash)
    dup.tap{ |a| a.merge!(hash) }
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

  private
    def stylize(value)
      Autostyle[value.is_a?(Hash) ? value : { '' => value }]
    end
end
