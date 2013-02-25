require 'activerecord-tableless'

class Savant::FactTable < ActiveRecord::Base
  has_no_table

  class Column
    attr_reader :name, :sql_type, :squeel

    def initialize(name, sql_type, squeel)
      @name = name.to_sym
      @sql_type = sql_type
      @squeel = squeel
    end
  end

  class Proxy
    attr_reader :calls

    def initialize
      @calls = []
    end

    [:string, :integer, :float, :boolean, :time, :date, :datetime].each do |type|
      define_method type do |name, &blk|
        @calls << [name, type, blk]
      end
    end
  end

  def self.raw_data
    grouped_by dimensions.map(&:name)
  end

  def self.dimensions(&blk)
    if block_given?
      Proxy.new.tap do |proxy|
        proxy.instance_eval &blk
        proxy.calls.each do |name, type, block|
          add_dimension Column.new(name, type, squeel(&block).as(name.to_s))
        end
      end
    end

    @_dimensions.values
  end

  def self.grouped_by(*columns)
    columns = Array.wrap(columns)

    select(columns).
      select(measures.map(&:squeel)).
      from(facts).
      group(columns)
  end

  def self.data_source(table_name = nil, &blk)
    if block_given?
      self.table_name = table_name || 'facts'
      @_data_source = blk.call
    end

    @_data_source
  end

  def self.measures(&blk)
    if block_given?
      Proxy.new.tap do |proxy|
        proxy.instance_eval &blk
        proxy.calls.each do |name, type, block|
          add_measure Column.new(name, type, squeel(&block).as(name.to_s))
        end
      end
    end

    @_measures.values
  end

  private

  def self.all
    data_source.select dimensions.map(&:squeel)
  end

  def self.fact_table_name
    @fact_table_name
  end

  def self.facts
    "(#{all.to_sql}) as #{self.table_name}"
  end

  def self.add_measure(measure)
    @_measures ||= {}
    @_measures[measure.name] = measure
    column measure.name, measure.sql_type
  end

  def self.add_dimension(dimension)
    @_dimensions ||= {}
    @_dimensions[dimension.name] = dimension
    column dimension.name, dimension.sql_type
  end
end
