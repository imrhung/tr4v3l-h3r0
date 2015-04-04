# Create Quest(F) #

Link:  virtualquest/insertVirtualQuest

  * POST with params:
    * partner\_id
    * packet\_id
    * name
    * point
    * quiz\_category
    * activity\_id\_1 (=0 means no choose)
    * activity\_id\_2
    * activity\_id\_3
    * donation\_id\_1 (=0 means no choose)
    * donation\_id\_2
    * donation\_id\_3
  * Response in json file.
if created successful:
```
{
  "code": 1,
  "message": "Success",
}
```
or error:
```
{
  "code": 0,
  "message": "Fail",
}
```

# Create Activity(F) #

Link: [activity/insertActivity]


  * POST with params:
    * partner\_id
    * title
    * description
    * action\_id
    * action\_content
  * Response in json file.
if created successful:
```
{
  "code": 1,
  "message": "Success",
}
```
or error:
```
{
  "code": 0,
  "message": "Fail",
}
```

# Create Donation(F) #

Link: [donation/insertDonation]

  * POST with params:
    * partner\_id
    * title
    * description.

  * Response:
    * Success:
```
{
  "code": 1,
  "message": "Success",
}
```
or error:
```
{
  "code": 0,
  "message": "Fail",
}
```


# Create Quiz(F) #

Link: [quiz/insertQuiz]

At this time, we will just create one quiz at a time.
  * POST with params:
    * partner\_id
    * category (is the the id of category)
    * question
    * image\_url
    * answer\_a
    * answer\_b
    * answer\_c
    * answer\_d
    * correct\_answer (will be 0/1/2/3)
    * sharing
    * link.
  * Response:
    * Success:
```
{
  "code": 1,
  "message": "Success",
}
```
or error:
```
{
  "code": 0,
  "message": "Fail",
}
```