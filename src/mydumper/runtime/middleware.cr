module Mydumper
  module Runtime
    module Middleware
      abstract class Entry
        abstract def call(job, ctx) : Bool
      end

      class Chain(T)
        property entries : Array(T)

        def initialize
          @entries = [] of T
        end

        def copy
          Chain(T).new.tap do |c|
            c.entries = @entries.dup
          end
        end

        def remove(klass)
          entries.reject! { |entry| entry.class == klass }
        end

        def add(klass)
          entries.delete klass
          entries.push klass
        end

        def prepend(klass)
          entries.delete(klass)
          entries.insert(0, klass)
        end

        def insert_before(oldklass, newklass)
          i = entries.index { |entry| entry.klass == newklass }
          new_entry = i.nil? ? newklass : entries.delete_at(i)
          i = entries.index { |entry| entry.klass == oldklass } || 0
          entries.insert(i, new_entry)
        end

        def insert_after(oldklass, newklass)
          i = entries.index { |entry| entry.klass == newklass }
          new_entry = i.nil? ? newklass : entries.delete_at(i)
          i = entries.index { |entry| entry.klass == oldklass } || entries.count - 1
          entries.insert(i + 1, new_entry)
        end

        def clear
          entries.clear
        end

        def invoke(job, ctx) : Bool
          chain = entries.map { |k| k }
          next_link(chain, job, ctx)
        end

        def next_link(chain, job, ctx) : Bool
          if chain.empty?
            true
          else
            if chain.shift.call(job, ctx)
              next_link(chain, job, ctx)
            else
              false
            end
          end
        end
      end
    end
  end
end
