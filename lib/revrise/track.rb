module RevRise
  class Track < API
    class << self
      def create(attributes={})
        attributes = attributes.reject { |k,v| k == :id } if attributes[:id]

        response = run(:post, :set_contact, with_root(attributes))
        response['result'] ? response['result']['id'].to_i : false
      end

      def update(attributes={})
        response = run :post, :set_contact, with_root(attributes)
        response['result'] ? response['result']['id'].to_i : false
      end

      private

      def with_root(attributes)
        {:contact => attributes}
      end
    end
  end
end
