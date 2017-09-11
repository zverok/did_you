# frozen_string_literal: true

begin
  require 'did_you_mean'
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

# Very simple "did you mean" style suggestor, wrapping different
# versions of did_you_mean gem, both when bundled in Ruby (2.3+)
# and not bundled (2.1-2.2).
#
# @example
#
#    DidYou::Spell.check('raise', %w[raise def class]) # => ["raise"]
#    DidYou::Spell.check('rais', %w[raise]) # => []
#
# @see Spell.check
module DidYou
  # See {.check}
  module Spell
    module_function

    # Checks mistyped word against provided dictionary.
    #
    # @param error [String] Mistyped word (say, method name).
    # @param dictionary [Array<String>] Dictionary of known words
    #   (say, defined methods).
    # @return [Array<String>] List of suggested spellings or `[]`
    #   if word is correct or did_you_mean gem is not found.
    #
    def check(error, dictionary)
      _check(error, dictionary) - [error]
    end

    private

    module_function

    if !Kernel.const_defined?(:DidYouMean)
      STDERR.puts 'did_you_mean gem not found.'
      def _check(*)
        []
      end
    elsif DidYouMean.const_defined?(:SpellCheckable) # 1.0 +
      SpellChecker = Struct.new(:error, :dictionary) do
        include DidYouMean::SpellCheckable

        def candidates
          { error => dictionary }
        end
      end

      def _check(error, dictionary)
        SpellChecker.new(error, dictionary).corrections
      end
    elsif DidYouMean.const_defined?(:SpellChecker) # 1.1+
      def _check(error, dictionary)
        DidYouMean::SpellChecker.new(dictionary: dictionary).correct(error)
      end
    elsif DidYouMean.const_defined?(:BaseFinder) # < 1.0
      SpellFinder = Struct.new(:error, :dictionary) do
        include DidYouMean::BaseFinder

        def searches
          { error => dictionary }
        end
      end

      def _check(error, dictionary)
        SpellFinder.new(error, dictionary).suggestions
      end
    else
      STDERR.puts 'Unrecognized did_you_mean version. '
      def check(*)
        []
      end
    end
  end
end
