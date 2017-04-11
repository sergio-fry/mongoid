# encoding: utf-8
module Mongoid
  module Association

    # Module for all builder object behavior. Builders are responsible for either
    # looking up a relation's target from the database, or creating them from a
    # supplied attributes hash.
    module Buildable
      include Threaded::Lifecycle

      attr_reader :base, :association, :object

      # Instantiate the new builder for a relation.
      #
      # @example Create the builder.
      #   Builder.new(association, { :field => "value })
      #
      # @param [ Document ] base The base document.
      # @param [ Association ] association The association metadata for the relation.
      # @param [ Hash, BSON::ObjectId ] object The attributes to build from or
      #   id to query with.
      #
      # @since 2.0.0.rc.1
      def initialize(base, association, object)
        @base, @association, @object = base, association, object
      end

      protected

      # Get the class from the association metadata.
      #
      # @example Get the class.
      #   builder.klass
      #
      # @return [ Class ] The class from the association metadata.
      #
      # @since 2.3.2
      def klass
        @klass ||= association.klass
      end

      # Do we need to perform a database query? It will be so if the object we
      # have is not a document.
      #
      # @example Should we query the database?
      #   builder.query?
      #
      # @return [ true, false ] Whether a database query should happen.
      #
      # @since 2.0.0.rc.1
      def query?
        obj = object.__array__.first
        !obj.is_a?(Mongoid::Document) && !obj.nil?
      end
    end
  end
end