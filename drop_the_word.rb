require 'active_support/core_ext/string/inflections'
module DropTheWord
  SHARP_NEEDLES = [
    %w(ド ド♯ レ レ♯ ミ ファ ファ♯ ソ ソ♯ ラ ラ♯ シ),
    %w(ど ど♯ れ れ♯ み ふぁ ふぁ♯ そ そ♯ ら ら♯ し),
    %w(C C♯ D D♯ E F F♯ G G♯ F F♯ A A♯ B),
    %w(c c♯ d d♯ e f f♯ g g♯ f f♯ a a♯ b),
  ]

  FLAT_NEEDLES = [
    %w(ド レ♭ レ ミ♭ ミ ファ ソ♭ ソ ラ♭ ラ シ♭ シ),
    %w(ど れ♭ れ み♭ み ふぁ そ♭ そ ら♭ ら し♭ し),
    %w(C D♭ D E♭ E F G♭ G F♭ F A♭ A B♭ B),
    %w(c d♭ d e♭ e f g♭ g f♭ f a♭ a b♭ b),
  ]

  AVAILABLE_TYPES = %i(sharp flat)

  class << self
    def drop(msg, type: :sharp)
      msg.gsub(/#{needles(type).join('|')}/, needle_hash(type))
    end

    def needle_hash(type)
      needles(type).each_with_object({}) do |char_needles, needle_hash|
        char_needles.each_with_index do |needle, idx|
          needle_hash[needle] = char_needles[idx - 1]
        end
      end
    end

    def needles(type)
      fail DropTypeUndefinedError, "#{type} is undefined" unless AVAILABLE_TYPES.include?(type)
      "DropTheWord::#{type.to_s.upcase}_NEEDLES".constantize
    end
  end
end

