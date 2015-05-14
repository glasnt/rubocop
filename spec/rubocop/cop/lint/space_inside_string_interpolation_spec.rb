# encoding: utf-8

require 'spec_helper'

describe RuboCop::Cop::Lint::SpaceInsideStringInterpolation do
  subject(:cop) { described_class.new }

  it 'registers an offense for spaces inside string interpolation' do
    inspect_source(cop, '"This is a #{ string} inside."')
    expect(cop.messages).to eq(['Space inside string interpolation detected.'])
  end

  it 'corrects spaces inside string interpolation' do
    corrected = autocorrect_source(cop, ['"some   #{ something} something"'])
    expect(corrected).to eq '"some   #{something} something"'
  end

  it 'registers an offense for variations of spaces inside string interpolation' do
    inspect_source(cop, ['"#{A }"',
                         '"#{ A }"',
                         '"#{ A}"'])
    expect(cop.messages).to eq(['Space inside string interpolation detected.'] * 3)
  end
end
