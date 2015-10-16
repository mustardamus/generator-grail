module.exports = (helpers) ->
  Schema = new @Schema
    name:     String
    tags:     Array
    settings: Object
    admin:    Boolean
  ,
    timestamps: true

  @model '{{modelName}}', Schema
