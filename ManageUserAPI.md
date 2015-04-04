# Introduction #

This page consists API for manage user functions.

# Get Partner's List #
Order by Register Date: recent first.
  * Request:
    * pageSize, (=0 will return all list)
    * pageNumber
  * Response:
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "partners": [
      {
        "Id": "4",
        "PartnerName": "NamAgape Childrens Home",
        "OrganizationTypeId": "3",
        "Address": "65/13 Phan Sao Nam",
        "PhoneNumber": "84912880656",
        "WebsiteURL": "",
        "Latitude": null,
        "Longtitude": null,
        "Description": "we help eartn",
        "IsApproved": "0"
      },
      {
        "Id": "3",
        "PartnerName": "Unicef VietNam",
        "OrganizationTypeId": "3",
        "Address": "65/13 Phan Sao Nam",
        "PhoneNumber": "84912880656",
        "WebsiteURL": "",
        "Latitude": null,
        "Longtitude": null,
        "Description": "We save the world",
        "IsApproved": "0"
      }
    ]
  }
}
```

# Get one partner #
  * Request
    * id
  * Response
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "partner": {
      "Id": "3",
      "PartnerName": "Unicef VietNam",
      "OrganizationTypeId": "3",
      "Address": "65/13 Phan Sao Nam",
      "PhoneNumber": "84912880656",
      "WebsiteURL": "",
      "Latitude": null,
      "Longtitude": null,
      "Description": "We save the world",
      "UserName": "unicef",
      "IsApproved": "0",
      "Email": "imrhung@yahoo.com"
    }
  }
}
```

# Delete Partner #
  * Request to:
    * id (id of that partner)
  * Responsse:
```
{
  "code": 1,
  "message": "Success"
}
```

# Approve/Deny partner #
  * Request to:
    * id
    * is\_approved (0:not set yet, 1: approved, 2: denied)
  * Response
```
{
  "code": 1,
  "message": "Success"
}
```