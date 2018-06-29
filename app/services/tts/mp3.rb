# frozen_string_literal: true

module TTS
  module MP3
    # Length of header that describes ID3 container
    ID3_HEADER_SIZE = 10

    def self.concatenate(first_part, second_part, output)
      # Read raw mp3s
      first  = File.binread(first_part)
      second = File.binread(second_part)

      # Get rid of ID3 tags
      strip_mp3!(first)
      strip_mp3!(second)

      # Concatenate mp3 frames
      result = first + second

      File.binwrite(output, result)
      output
    end

    # Get size of ID3 container.
    # Length is stored in 4 bytes, and the 7th bit of every byte is ignored.
    #
    # Example:
    #         Hex: 00       00       07       76
    #         Bin: 00000000 00000000 00000111 01110110
    #    Real bin:                        111  1110110
    #    Real dec: 1014
    #
    def self.get_id3_size(header)
      result = 0
      str = header[6..9]

      # Read 4 size bytes from left to right applying bit mask to exclude 7th bit
      # in every byte.
      4.times do |i|
        result += (str[i].ord & 0x7F) * (2**(7 * (3 - i)))
      end

      result
    end

    def self.strip_mp3!(raw_mp3)
      # 10 bytes that describe ID3 container.
      id3_header = raw_mp3[0...ID3_HEADER_SIZE]
      id3_size = get_id3_size(id3_header)

      # Offset from which mp3 frames start
      offset = id3_size + ID3_HEADER_SIZE

      # Get rid of ID3 container
      raw_mp3.slice!(0...offset)
      raw_mp3
    end
  end
end
