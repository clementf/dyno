# frozen_string_literal: true

# Validates things related to Blocks and languages
# - base language and target language should be different
class BlockValidator < ActiveModel::Validator
  def validate(record)
    add_lang_error(record) if record.target_lang == record.base_lang
  end

  private

  def add_lang_error(record)
    record.errors[:language] << 'Base and target languages should be different'
  end
end
