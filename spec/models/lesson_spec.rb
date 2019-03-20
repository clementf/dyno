# frozen_string_literal: true

require 'rails_helper'

describe Lesson do
  it { is_expected.to have_and_belong_to_many(:blocks) }
end
