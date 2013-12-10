require 'activerecord-tableless'

class Savant::FactTable < ActiveRecord::Base
  has_no_table

  class Column
    attr_reader :name, :sql_type, :squeel, :description

    def initialize(name, sql_type, description, squeel)
      @name = name.to_sym
      @sql_type = sql_type
      @squeel = squeel
      @description = description
    end
  end

  class Proxy
    attr_reader :calls

    def initialize
      @calls = []
    end

    [:string, :integer, :float, :boolean, :time, :date, :datetime, :decimal].each do |type|
      define_method type do |name, description='', &blk|
        @calls << [name, type, description, blk]
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
        proxy.calls.each do |name, type, description, block|
          add_dimension Column.new(name, type, description, squeel(&block).as(name.to_s))
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
        proxy.calls.each do |name, type, description, block|
          add_measure Column.new(name, type, description, squeel(&block).as(name.to_s))
        end
      end
    else
      @_measures ||= {}
      @_measures.values
    end
  end

  private

  def self.all
    data_source.select dimensions.map(&:squeel)
  end

  def self.fact_table_name
    @fact_table_name
  end

  def self.facts
    "(#{all.to_sql}) as \"#{self.table_name}\""
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
