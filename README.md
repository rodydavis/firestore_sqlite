# Firebase SQLite

Taking [Cloud Firestore ODM](https://pub.dev/packages/cloud_firestore_odm) to the next level.

The following is a proposal I will be aiming to build.

## Admin UI

The Admin UI is a web interface for managing your database in firestore and is deployed as a separate firebase hosting site in the same project.

## Schemas

The schemas are located under a top level doc in the firestore collection called `collections`.

The schema is a JSON object that describes the fields in the collection.

The schema is used to generate the UI for the collection and to validate the data on save.

    This schema could also be saved to Firebase remote config for dynamic schema changes.

All fields are optional unless marked as required!

Types:
- string (text)
- number (int,double,float,decimal,number)
- bool (truthy or falsy)
- date (stored as a timestamp)
- array (type|object)
- map (json)
- option (enum field)
- file (object reference to blob)
- document (foreign key to another collection)

For file types thumbnails can be auto generated using a Firebase function and also triggers to remove the document on deletion in cloud storage.

### Schema Changes

Given an object with two fields:

```json
{
    "name": "John Doe",
    "age": 20
}
```

Before schema change:

```json
{
    "name": "users",
    "description": "Users collection",
    "fields": [
        {
            "name": "name",
            "type": "string",
            "required": true,
            "description": "Name of the user"
        },
        {
            "name": "age",
            "type": "number",
            "description": "Age of the user"
        }
    ]
}
```

**description** is optional and will only be used in the UI and class generation.

There are some auto generated fields created to help with the UI and class generation:

- **@id** (string) - The id of the document
- **@created** (date) - The date the document was created
- **@updated** (date) - The date the document was last updated

    These fields are not required in the schema but will be added to the document.

After rename `name` field to `display_name` and applying schema change:

```json
{
    "name": "users",
    "description": "Users collection",
    "fields": [
        {
            "name": "display_name",
            "type": "string",
            "required": true,
            "description": "Name of the user",
            "previous": ["name"]
        },
        {
            "name": "age",
            "type": "number",
            "description": "Age of the user",
            "default": 0
        }
    ]
}
```

The `previous` field is used to map the old field name to the new field name and is used to migrate the data.

The `default` field is used to provide a fallback value when creating a document if the field is not set.

When new classes are generated the new field name is used but existing classes in production will still use the old field name and check the field in previous.

    Note that if a field is required it needs a default value for any existing clients using the old version.

It is probably good to consider everything optional unless when first setting it as required from the beginning.

After a schema is updated and a client received the change it will update the schema in the local database and then update the UI.

### Import / Export

All the schemas can be exported to a JSON file and imported back in.

## SDK

Using the schema it is possible to generate helper classes, endpoints and more.

    Data is store in Firebase in a normalized format (no sub collections) since it will work better with queries and SDK generation.

### Validation

The schema is used to validate the data on the client side before saving to firestore.

Since Firestore is NoSQL any data can be saved to the database but this is an extra layer of validation to ensure the data is valid/expected.

Shared forms used for the Admin UI can be used in the Client UI and the validation will be the same.

### Full Text Search

Full text search is possible client side by using the SQLite FTS5 extension.

### Graph Database

GraphDB is possible client side by using the SQLite jsonb extension and some virtual tables.

By default no links/edges are created but can be added to the schema. (Work in progress)

```json
{
    "name": "users",
    "description": "Users collection",
    "fields": [
        {
            "name": "name",
            "type": "string",
            "required": true,
            "description": "Name of the user"
        },
        {
            "name": "age",
            "type": "number",
            "description": "Age of the user"
        }
    ],
    "links": [
        {
            "name": "friends",
            "type": "users",
            "description": "Friends of the user"
        }
    ]
}
```

When a document is added to the local SQLite database it will create a link to the target document (even if it does not exist yet).

```json
{
    "name": "users",
    "description": "Users collection",
    "fields": [
        {
            "name": "name",
            "type": "string",
            "required": true,
            "description": "Name of the user"
        },
        {
            "name": "age",
            "type": "number",
            "description": "Age of the user"
        },
        {
            "name": "group_id",
            "type": "document",
            "collection": "groups",
            "description": "Group the user is a part of"
        }
    ]
}
```

If a `document` type is used the `collection` field is also needed to define the relationship. If it is not provided then the foreign key is not enforced.

### Class Generation

The classes are a combination of the schema and the data.

When the schema is changed the classes need to be regenerated but can always access product data by falling back to the `previous` field if a key not found.

### Firebase Functions

By defining relationships in the schema, you can generate functions based on triggers for deletion and updating.

For a given collection **Albums** and another collection **Songs**, if the album schema has a trigger to remove a song from the album when the song is deleted, then a firebase function will be setup to watch the correct records.

### GraphQL (Optional)

GraphQL end point can be generated from the schema.

### Rest API (Optional)

Rest API can be generated from the schema.

## Data Migration

To migrate the data from the old schema to the new schema the following steps are required:

1. Generate the new classes from the new schema.
2. Update the client side code to use the new classes.

Since Firestore is NoSQL and not relational the data can be migrated in any order and renamed fields can be mapped to the new field name.

## Data Import

To import data from a json file the following steps are required:

1. Generate the classes from the schema.
2. Parse the json file and convert to the generated classes.
3. Use the Admin UI to upload the data.

## Client SDK

Lazy loading of the data is possible by using the client SDK.

For example if you have parts of the data in the client cache and you want to load the rest of the data from the server.

Since it is a relational database the data queried and sorted in multiple ways.

## Logging / Analytics

The data can be logged to the database and used for analytics.

Even if the data is local and a call to the server is not required Firebase Analytics will be used to log every action.

## Sync

Since the database is a SQLite file it is possible to sync the local database for a user across multiple devices using a cloud storage provider like Firebase Storage and/or [iCloud Storage](https://pub.dev/packages/icloud_storage).

It is easy to check for updates on the document by using the `@updated` field.

## Deletion

Deleted documents are not removed from the database but marked as deleted (tombstone pattern or soft delete).

You can still query the deleted documents but they will not be returned in the results (unless you query for deleted documents).

A cron job can be used to remove the deleted documents after a certain period of time.

## Time to Live

Using the new firebase feature we can set a TTL on a given collection to help clean up documents.

This is used for [logging](#logging--analytics) collection and has a default of 30 days.
