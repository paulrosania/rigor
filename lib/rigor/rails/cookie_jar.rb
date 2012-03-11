module Rigor
  class Middleware
    class CookieJar
      def initialize(cookies)
        @cookies = cookies
      end

      def [](experiment_id)
        cookies["_rigor_experiment_#{experiment_id}"]
      end

      def []=(experiment_id, value)
        cookies["_rigor_experiment_#{experiment_id}"] = value
      end

      def each(&block)
        cookies.select { |k,v| k =~ /^_rigor_experiment_/ }.each(&block)
      end

      def delete(experiment_id)
        cookies.delete("_rigor_experiment_#{experiment_id}")
      end

      def treatments
        reduce({}) do |hash, (cookie_name, treatment_idx)|
          experiment_id = cookie_name.match(/_rigor_experiment_([0-9]+)/)[1]
          hash[experiment_id] = treatment_idx
          hash
        end
      end

      protected

      attr_reader :cookies
    end
  end
end
