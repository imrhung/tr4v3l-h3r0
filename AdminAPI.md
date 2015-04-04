# Get a VirtualQuest(F) #
  * Link: http://localhost:1443/heroforzero/virtualquest/getVirtualQuest
  * equest: Post to :
> > Input params:
      * id
  * esponse:
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "quest": {
      "Id": 1,
      "QuestName": "abcxyz",
      "PartnerName": "Action's Name",
      "UnlockPoint": 100,
      "CreatedDate": "2014/03/02",
      "PacketName": "HCM",
      "PacketId": 1
    },
    "condition": [
      {
        "Id": 1,
        "Type": 1,
        "ObjectId": 4,
        "Title": "500 points",
        "Value": 500
      },
      {
        "Id": 1,
        "Type": 1,
        "ObjectId": 4,
        "Title": "400 points"
        "Value": 500
      }
    ]
  }
}
```

# Get VirtualQuest List(F) #
  * Link: http://localhost:1443/heroforzero/virtualquest/getVirtualQuestList
  * Request: POST
> > Input parameters:
      * pageSize (pageSize == 0 will return full list)
      * pageNumber.
  * Response:
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "quest": [
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "UnlockPoint": 500,
        "CreatedDate": "2014/03/04"
      },
      {
        "Id": 1,
        "QuestName": "Rescure",
        "PacketName": "HCM",
        "UnlockPoint": 500,
        "CreatedDate": "2014/03/04"
      }
    ]
  }
}
```

# Edit Virtual Quest(F) #
Link:

**POST with params:
  * id
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
  * donation\_id\_3**Response in json file.
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

# Delete VirtualQuest(F) #
  * Link:  http://localhost:1443/heroforzero/virtualquest/deleteVirtualQuest
Request:
Params: id

Response:
```
{
  "code": 1,
  "message": "Success"
}
```

# Get a activity(F) #
  * Link: http://localhost:1443/heroforzero/activity/getActivity
  * Request: POST
> > Input parameters:
      * id (id of Activity: INT)
  * Response:
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "activity": {
      "Id": 1,
      "PartnerId": 2,
      "ActionId": 1,
      "ActionContent": "abcxyz",
      "Description": "abcxyz",
      "Title": "http://abcxyz",
      "PartnerName": "Action's Name",
      "BonusPoint": 100,
      "CreateDate": "2014/03/02",
      "IsApproved": 1
    }
  }
}
```


# Get activity list(F) #
Order by newest first.
  * Link: http://localhost:1443/heroforzero/activity/getActivityList
  * Request:

> params:
    * pageSize (pageSize == 0 will return full list)
    * pageNumber.
  * Response:
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "activity": [
      {
        "Id": 1,
        "PartnerId": 2,
        "ActionId": 1,
        "ActionContent": "abcxyz",
        "Description": "abcxyz",
        "Title": "http://abcxyz",
        "PartnerName": "Action's Name",
        "BonusPoint": 100,
        "CreatedDate": "2014/03/02",
        "IsApproved": 1
      },
      {
        "Id": 1,
        "PartnerId": 2,
        "ActionId": 1,
        "ActionContent": "abcxyz",
        "Description": "abcxyz",
        "Title": "http://abcxyz",
        "PartnerName": "Action's Name",
        "BonusPoint": 100,
        "CreatedDate": "2014/03/02",
        "IsApproved": 1
      }
    ]
  }
}
```

# Edit Activity(F) #
Link: activity/updateActivity


  * POST with params:
    * id
    * partner\_id
    * title
    * description
    * action\_id
    * action\_content
    * point
    * approve (0 : not approve, 1 is approved)
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

# Update Point Value Activity(F) #
  * Link: http://localhost:1443/heroforzero/activity/updateActivity
  * Request:
> > Input value:
    * id
    * point
  * Response:
```
{
  "code": 1,
  "message": "Success",
}
```

# Approve/Deny Activity(F) #
  * Link: http://localhost:1443/heroforzero/activity/updateIsApproved
  * Request:
> > Params:
      * id
      * is\_approved (0:not set yet, 1: approved, 2: denied)
  * Response:
```
{
  "code": 1,
  "message": "Success"
}
```

# Delete Activity(F) #
  * Link: http://localhost:1443/heroforzero/activity/deleteActivity
Request: POST to Link:

Params: id

Response:
```
{
  "code": 1,
  "message": "Success"
}
```

# Get a donation(F) #
  * Link: donation/getDonation
  * Request:
    * id
  * Response:
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "donation": {
      "Id": 1,
      "PartnerId": 2,
      "Description": "abcxyz",
      "Title": "http://abcxyz",
      "PartnerName": "Action's Name",
      "RequiredPoint": 100,
      "CreatedDate": "2014/03/02",
      "IsApproved": 1
    }
  }
}
```
# Get donation list(F) #
Order by newest first.
  * Link: donation/getDonationList
  * Request:
> > params:
      * pageSize (pageSize == 0 will return full list)
      * pageNumber (start from 0).
  * Response:
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "donation": [
      {
        "Id": 1,
        "PartnerId": 2,
        "Description": "abcxyz",
        "Title": "http://abcxyz",
        "PartnerName": "Action's Name",
        "RequiredPoint": 100,
        "CreatedDate": "2014/03/02",
        "IsApproved": 1
      },
      {
        "Id": 1,
        "PartnerId": 2,
        "Description": "abcxyz",
        "Title": "http://abcxyz",
        "PartnerName": "Action's Name",
        "RequiredPoint": 100,
        "CreatedDate": "2014/03/02",
        "IsApproved": 1
      }
    ]
  }
}
```

# Edit Donation(F) #

Link: donation/updateDonation

  * POST with params:
    * id
    * partner\_id
    * title
    * description.
    * approve
    * point

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

# Update donation RequiredPoint(F)? #
  * Request: POST to link: donation/updateRequiredPoint
> > Params:
      * id
      * point
  * Response:
```
{
  "code": 1,
  "message": "Success",
 
}
```


# Approve/Deny donation(F) #
  * Request: POST to Link:

> Params:
    * id
    * is\_approved (0:not set yet, 1: approved, 2: denied)
  * Response:
```
{
  "code": 1,
  "message": "Success"
}
```

# Delete Donation(F) #
Request: POST to Link: donation/deleteDonation

Params: id

Response:
```
{
  "code": 1,
  "message": "Success"
}
```

# Get Quiz list(F) #
Order by newest first.

Request: POST to Link: quiz/getQuizList

params: pageSize (pageSize == 0 will return full list), pageNumber.


Response:
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "quiz": [
      {
        "Id": 1,
        "CategoryName": "Teaching",      
        "IsApproved": 1,
        "PartnerName": "Partner's Name",
        "CreateDate": "2014/04/03",
  
      },
      {
        "Id": 1,
        "CategoryName": "Teaching",       
        "IsApproved": 1,
        "PartnerName": "Partner's Name",
        "CreateDate": "2014/04/03",
      }
    ]
  }
}
```

# Get Quiz List with Answers #
Order by newest first.

Request: POST to Link: quiz/getQuizChoiceList

params: page\_size (pageSize == 0 will return full list), page\_number.

Response:
```
{
    "code": 1,
    "message": "Success",
    "quiz": [
        {
            "id": "85",
            "content": "What type are the children at the pagoda categorized as? ",
            "image_url": "",
            "correct_choice_id": "241",
            "learn_more_url": "",
            "point": "1",
            "sharing_info": "",
            "CategoryName": "No Category",
            "CreatedDate": "2014-06-16 07:40:41",
            "IsApproved": null,
            "PartnerName": "Buddhist Social Charity Center of Ky Quang Pa",
            "choice_type": 0,
            "choice": [
                {
                    "id": "238",
                    "content": "Abandoned or orphaned children. "
                },
                {
                    "id": "239",
                    "content": "Disabled children."
                },
                {
                    "id": "240",
                    "content": "Immigrant children from other local areas. "
                },
                {
                    "id": "241",
                    "content": "All of the above."
                }
            ]
        }
    ]
}
```

# Get one Quiz(F) #

Request: POST to Link: quiz/getQuiz

Params: id

Response:
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "quiz": {
      "quiz": {
        "Id": "25",
        "BonusPoint": "200",
        "CreatedDate": "2014-03-24 11:48:11",
        "CorrectChoiceId": "20",
        "SharingInfo": "0",
        "LearnMoreURL": "0",
        "ImageURL": null,
        "IsApproved": "1",
        "CategoryName": "ocean4",
        "PartnerName": "UNICEF",
        "CategoryId": "1",
        "Content": "0"
      },
      "choice": [
        {
          "Id": "17",
          "answerContent": "0"
        },
        {
          "Id": "18",
          "answerContent": "0"
        },
        {
          "Id": "19",
          "answerContent": "0"
        },
        {
          "Id": "20",
          "answerContent": "0"
        }
      ]
    }
  }
}
```

# Edit Quiz(F) #

Request: POST to Link: quiz/updateQuiz

Params: id, category (is the the id of category), question, answer\_a, answer\_b, answer\_c, answer\_d, correct\_answer (will be 0/1/2/3), sharing, link.

Response:
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "quiz": {
      "Id": 1,
        "CategoryId": 1,
        "PartnerId": 2,
        "Content": "abcxyz",
        "BonusPoint": 100,
        "CreatedDate": 1002,
        "CorrectChoiceId": 1,
        "SharingInfo": "abcxyz",
        "LearnMoreURL": "http://abcxyz",
        "ImageURL": "http://abcxyz",
        "IsApproved": 1,
        "CategoryName": "Teaching",
        "PartnerName": "Partner's Name",
        "AnswerA": "1234",
        "AnswerB": "1234",
        "AnswerC": "1234",
        "AnswerD": "1234",
        "AnswerAId": 2,
        "AnswerBId": 3,
        "AnswerCId": 4,
        "AnswerDId": 5
    }
  }
}
```

# Update quiz points(F) #

Request: POST to link: quiz/updateBonusPoint

Params: id, point

Response:
```
{
  "code": 1,
  "message": "Success",
}
```


# Approve/Deny quiz(F) #

  * Request: POST to Link: quiz/updateIsApproved
> > Input Values:
      * id
      * is\_approved (0:not set yet, 1: approved, 2: denied)
  * Response:
```
{
  "code": 1,
  "message": "Success"
}
```


# Delete quiz(F) #

Request: POST to Link: quiz/deleteQuiz

Params: id


Response:
```
{
  "code": 1,
  "message": "Success"
}
```