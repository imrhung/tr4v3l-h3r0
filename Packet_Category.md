# Get packet list(F) #
POST to link: packet/getPacketList
  * Request
> Input parameters:
    * pageSize (pageSize == 0 will return full list)
    * pageNumber.
  * Response:
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "packet": [
      {
        "Id": 1,
        "Title": "Ho Chi Minh"
      },
      {
        "Id": 1,
        "Title": "Ho Chi Minh"
      },
      {
        "Id": 1,
        "Title": "Ho Chi Minh"
      }
    ]
  }
}
```

# Add packet(F) #
  * Request: POST to link: packet/insertPacket
> Params:
    * title(string)
    * image\_url(string)
    * partner\_id(int)
  * Response:
```
{
  "code": 1,
  "message": "Success",
}
```

# Get Quiz category list(F) #
Request: POST to link: quizcategory/getQuizCategoryList

Response:
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "category": [
      {
        "Id": 1,
        "CategoryName": "Children"
      },
      {
        "Id": 1,
        "CategoryName": "Children"
      }
    ]
  }
}
```


# Add Quiz category(F) #
  * Link: quizcategory/insertQuizCategory
  * Request:
> > Input Values:
      * category\_name (string)
  * Response:
```
    {
      "code": 1,
      "message": "Success"
    }
```