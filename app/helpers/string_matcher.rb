require 'fuzzystringmatch'
module StringMatcher

    extend self

    def same_strings?(latest_prompt, new_prompt)
      jarow = FuzzyStringMatch::JaroWinkler.create(:native)
      jarow.getDistance(latest_prompt, new_prompt) >= 0.9
    end
  end
