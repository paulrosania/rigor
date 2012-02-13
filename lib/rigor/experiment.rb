module Rigor
  class Experiment
    def self.load_from(filename)
      instance_eval(File.read(filename)).tap do |e|
        @experiments ||= {}
        @experiments[e.name] = e
      end
    end

    def self.experiment(name, &block)
      new(name).tap do |e|
        DSL.new(e).instance_eval(&block)
      end
    end

    def self.all
      @experiments
    end

    def self.find_by_name(name)
      all.values.find { |e| e.name == name }
    end

    def initialize(name)
      @name = name
      @treatments = []
    end

    attr_accessor :description
    attr_accessor :name
    attr_reader :treatments

    def add_treatment(treatment)
      @treatments << treatment
    end

    def random_treatment
      treatment_max = 0
      assignment = rand(cumulative_weights)
      treatments.each do |treatment|
        treatment_max += treatment.weight
        return treatment if assignment < treatment_max
      end
    end

    protected

    def cumulative_weights
      treatments.map(&:weight).sum
    end

    class DSL
      def initialize(experiment)
        @experiment = experiment
      end

      def description(description)
        @experiment.description = description
      end

      def treatment(name, options = {})
        @experiment.add_treatment(Treatment.new(name, options))
      end
    end
  end
end
