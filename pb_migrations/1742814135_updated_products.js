/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_4092854851")

  // update collection data
  unmarshal({
    "deleteRule": "@request.auth.id = \"\"",
    "updateRule": "@request.auth.id = \"\""
  }, collection)

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_4092854851")

  // update collection data
  unmarshal({
    "deleteRule": "@request.auth.id = userId",
    "updateRule": "@request.auth.id = userId"
  }, collection)

  return app.save(collection)
})
