module Acorn
  class Normalize
    class << self
      def email(email)
        email&.strip&.downcase
      end

      def slug_name(name)
        name&.downcase&.parameterize
      end
    end
  end
end

