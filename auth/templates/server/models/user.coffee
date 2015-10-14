module.exports = (helpers) ->
  Schema = new @Schema
    username: String
    password: String
    email   : String
  ,
    timestamps: true

  @model 'User', Schema
