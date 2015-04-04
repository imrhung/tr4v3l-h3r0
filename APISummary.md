An API should be do by a POST method.
Response will follow this format:

```
{
  "code": 1,
  "message": "Success",
  "info": any information
}
```

or fail:

```
{
  "code": 0,
  "message": "Fail",
  "info": any information
}
```