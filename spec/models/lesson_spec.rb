# frozen_string_literal: true

require 'rails_helper'

describe Lesson do
  it { is_expected.to have_many(:blocks) }
end
