# Get Partner Extended Information #
Request: to : partner/getPartnerExt
  * partner\_id
Response:
```
{
    "code": 1,
    "message": "Success",
    "info": {
        "partner_ext": {
            "partner_id": "17",
            "fanpage": "https://sdfslfldk",
            "donation_message": "Help you will be returned.",
            "donation_link": "hi there",
            "donation_paypal": "httpsdfsfddjf",
            "donation_address": "122 sdfsfds"
        }
    }
}
```

There are case that partner have not enter this information, the return will be:
```
{
    "code": 0,
    "message": "Fail"
}
```

# Get player avatar #
Request: to : service/getavatar
  * avatar\_id (Put nothing if wanna get all avatar)
Response:
```
{
    "code": 1,
    "message": "Success",
    "info": {
        "id": "2",
        "name": "Boy hero",
        "avatar_url": "http://www.heroforzero.be/assets/img/player/boy_hero@2x.png"
    }
}
```

# Update player avatar #
Request: to : service/updateavatar
  * user\_id
  * avatar\_id
  * facebook\_id : put '0' if do not use facebook.
Response:
```
{
    "code": 1,
    "message": "Success"
}
```




# Edit get virtual quest 10-May #
Request: /virtualquest/getVirtualQuest
  * id
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "quest": {
      "vId": "10",
      "vQuestName": "Heal the world",
      "vPacketId": "4",
      "vPartnerId": "5",
      "vAnimationId": "1",
      "vUnlockPoint": "500",
      "vCreateDate": "2014-05-05 07:31:44",
      "kTitle": "Nha Trang",
      "kImageURL": "http://mytempbucket.s3.amazonaws.com/1398069259.jpg",
      "kPartnerId": "1",
      "pId": "5",
      "pPartnerName": "UNICEF Viet Nam",
      "pOrganizationTypeId": "2",
      "pAddress": "Sun Wah Tower, Suite 504, 115 Nguyen Hue, District 1, HCMC",
      "pPhoneNumber": "+84 3821-9413",
      "pWebsiteUrl": "http://www.unicef.org/vietnam",
      "pLatitude": null,
      "pLongtitude": null,
      "pDescription": "UNICEFs mission in Vietnam is to fulfill the rights of every child in Vietnam, particularly those most disadvantaged or vulnerable.",
      "pIsApproved": "1",
      "pLogoUrl": "http://www.unicef.org/vietnam/unicef-logo.gif",
      "pIconUrl": "https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-unicef-big%402x.png",
      "condition": {
        "1": {
          "cId": "29",
          "cType": "1",
          "cValue": null,
          "cVirtualQuestId": "10",
          "cObjectId": "12",
          "action": {
            "aId": "12",
            "aPartnerId": "19",
            "aTitle": "Working as a volunteer to raise funds.",
            "aDescription": "Working as a volunteer to raise funds ( writing a proposal, making an event, finding sponsors,…)",
            "aActionId": "1",
            "aBonusPoint": "100",
            "aIsApproved": null,
            "aCreateDate": "2014-04-24 03:35:39",
            "aActionContent": "Working as a volunteer to raise funds ( writing a proposal, making an event, finding sponsors,…)"
          }
        },
        "2": {
          "cId": "30",
          "cType": "1",
          "cValue": null,
          "cVirtualQuestId": "10",
          "cObjectId": "18",
          "action": {
            "aId": "18",
            "aPartnerId": "23",
            "aTitle": "Doing volunteer work at the organization. ",
            "aDescription": "Doing volunteer work at the organization. ",
            "aActionId": "1",
            "aBonusPoint": "100",
            "aIsApproved": null,
            "aCreateDate": "2014-04-28 16:32:08",
            "aActionContent": "Doing volunteer work at the organization. "
          }
        },
        "3": {
          "cId": "31",
          "cType": "1",
          "cValue": null,
          "cVirtualQuestId": "10",
          "cObjectId": "17",
          "action": {
            "aId": "17",
            "aPartnerId": "22",
            "aTitle": "Participating in volunteer activities to look after and orient the children at the center. ",
            "aDescription": "Participating in volunteer activities to look after and orient the children at the center. ",
            "aActionId": "1",
            "aBonusPoint": "100",
            "aIsApproved": null,
            "aCreateDate": "2014-04-28 16:00:58",
            "aActionContent": "Participating in volunteer activities to look after and orient the children at the center. "
          }
        },
        "4": {
          "cId": "32",
          "cType": "2",
          "cValue": null,
          "cVirtualQuestId": "10",
          "cObjectId": "12",
          "donation": {
            "dId": "12",
            "dTitle": "Donate 50 dollars ",
            "dDescription": "Donate 50 dollars – equivalent to the cost of Emergency support for children victims of abused, and exploitation. ",
            "dRequiredPoint": "100",
            "dMedalId": "0",
            "dPartnerId": "5",
            "dIsApproved": null,
            "dCreateDate": "2014-04-07 10:26:56"
          }
        }
      }
    }
  }
}
```


# Get leader board #
Request: to : service/getLeaderBoard
  * page\_number
  * page\_size (= 0 will return all)
  * friends\_fbid : JSON string
```
{
  "friends_fbid": [
    "100000334657072",
    "1498934909",
    "100002646112287",
    "100000561357440",
    "85500069",
    "100002989569961"
  ]
}
```
Response:
```
{
  "code": 1,
  "message": "Success",
  "leaderboard": [
    {
      "id": 8,
      "name": "Luan",
      "mark": 160,
      "facebook_id": "100000561357440",
      "current_level": 3
    },
    {
      "id": 8,
      "name": "Luan",
      "mark": 160,
      "facebook_id": "100000561357440",
      "current_level": 3
    }
  ]
}
```



# Get user rank in leader board #
Request: to : service/getUserRank
  * user\_id

Response:
```
{
    "code": 1,
    "message": "Success",
    "user": {
        "id": "1",
        "name": "Vu Hoang Son",
        "mark": "119",
        "facebook_id": "1498934909",
        "current_level": "0",
        "rank": "3"
    }
}
```

# Get Quiz List #
Request: to : /service/getQuizz
  * page\_size : The number of needed questions
  * page\_number : (not in use now)
  * quest\_id :
  * random : provide random value 1 to get random quiz without category
Response:
```
{
  "code": 1,
  "message": "Success",
  "animation": {
    "id": "0",
    "time": "60",
    "hero_anim_walking": "walking",
    "hero_anim_standby": "standby",
    "monster_anim": "death_walking",
    "kid_frame": "sick-boy-1.png",
    "color_R": 242,
    "color_G": 156,
    "color_B": 51
  },
  "quizzes": [
    {
      "id": "0",
      "content": "How many children living with HIV in 2012? ",
      "image_url": "",
      "correct_choice_id": 3,
      "learn_more_url": "http://www.seahorse.vn",
      "point": "10",
      "sharing_info": "Did you know that 5500 children living with HIV in 2012",
      "choice_type": 1,
      "choice": [
        {
          "id": "0",
          "content": "100"
        },
        {
          "id": "1",
          "content": "1000"
        },
        {
          "id": "2",
          "content": "5000"
        },
        {
          "id": "3",
          "content": "5500"
        }
      ]
    },
    {
      "id": "1",
      "content": "What should you do in Vietnam if you see a child in situation where he/she looks like he/she needs help from an aggressor?",
      "image_url": "",
      "correct_choice_id": 2,
      "learn_more_url": "",
      "point": "10",
      "sharing_info": "What should you do in Vietnam if you see a child in situation where he/she looks like he/she needs help from an aggressor?",
      "choice_type": 0,
      "choice": [
        {
          "id": "0",
          "content": "Run and Hide"
        },
        {
          "id": "1",
          "content": "Ignore it"
        },
        {
          "id": "2",
          "content": "Call the 113 or 18001567 hotline to report"
        },
        {
          "id": "3",
          "content": "Confront the aggressor"
        }
      ]
    }
  ]
}
```

# Get User Medal/ Awards #
Request: to : /service/getUserMedal
  * page\_size : (=0 will return all records)
  * page\_number :
  * user\_id : Id of this user.
Response:
Result was order from latest to earlier.
```
{
  "code": 1,
  "message": "Success",
  "user_medal": [
    {
      "Id": "6",
      "MedalId": "2",
      "Name": "Hero I",
      "ImageURL": "https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/medal/medal2.png"
    },
    {
      "Id": "2",
      "MedalId": "2",
      "Name": "Hero I",
      "ImageURL": "https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/medal/medal2.png"
    }
  ]
}
```

# Register with FacebookId #
Request to: service/registerUserFb
  * fullName
  * phone
  * email
  * facebookId

Response:
```
{
  "code": 1,
  "message": "Success",
  "info": [
    {
      "code": "1",
      "message": "Regist successful",
      "userId": "20",
      "facebookId": "86756578",
      "points": "0",
      "currentLv": "0",
      "quests": [
        {
          "id": "1",
          "questName": "Test A",
          "packetId": "1",
          "partnerId": "1",
          "animationId": "1",
          "unlockPoint": "500",
          "createDate": null,
          "status": "1",
          "conditions": [
            {
              "id": "1",
              "type": "1",
              "value": "1",
              "virtualQuestId": "1",
              "objectId": "1"
            },
            {
              "id": "2",
              "type": "1",
              "value": "1",
              "virtualQuestId": "1",
              "objectId": "1"
            },
            {
              "id": "3",
              "type": "1",
              "value": "1",
              "virtualQuestId": "1",
              "objectId": "1"
            }
          ]
        }
      ]
    }
  ]
}
```


# Register with Device ID #
Request to: service/registerUser (to register) or service/loginUser (to login)
  * user\_name
  * device\_id

Response:
```
{
    "code": 1,
    "message": "Success",
    "info": [
        {
            "userId": "35",
            "facebookId": null,
            "points": "0",
            "currentLv": "0",
            "device_id": "2345678qwertyui",
            "quests": [
                {
                    "id": "1",
                    "questName": "Save Nam, a sick boy",
                    "packetId": "1",
                    "partnerId": "5",
                    "animationId": "3",
                    "unlockPoint": "0",
                    "createDate": null,
                    "status": "1",
                    "conditions": [
                        {
                            "id": "327",
                            "type": "0",
                            "value": "10",
                            "virtualQuestId": "1",
                            "objectId": "1",
                            "is_completed": "0"
                        },
                        {
                            "id": "328",
                            "type": "1",
                            "value": "0",
                            "virtualQuestId": "1",
                            "objectId": "7",
                            "is_completed": "0"
                        }
                    ]
                }
            ]
        }
    ]
}
```
or (for register)
```
{
    "code": 2,
    "message": "User Name Existed"
}
```
or (for login)
```
{
    "code": 3,
    "message": "User has not logged in"
}
```


# Get Packets #
Request : /service/getPackets
  * pageSize :
  * pageIndex :
```
{
  "code": 1,
  "message": "Success",
  "info": {
    "packet": [
      {
        "Id": "1",
        "Title": "Ho Chi Minh City",
        "ImageURL": "http://mytempbucket.s3.amazonaws.com/1398069259.jpg",
        "Quests": [
          {
            "Id": "1",
            "vQuestName": "Test A",
            "vPacketId": "1",
            "vPartnerId": "1",
            "vAnimationId": "1",
            "UnlockPoint": "500",
            "vCreateDate": null,
            "Condition": [
              {
                "Id": "1",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "1",
                "ObjectId": "1"
              },
              {
                "Id": "2",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "1",
                "ObjectId": "1"
              },
              {
                "Id": "3",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "1",
                "ObjectId": "1"
              }
            ]
          },
          {
            "Id": "2",
            "vQuestName": "Test B",
            "vPacketId": "1",
            "vPartnerId": "1",
            "vAnimationId": "1",
            "UnlockPoint": "1000",
            "vCreateDate": null,
            "Condition": [
              {
                "Id": "4",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "2",
                "ObjectId": "1"
              },
              {
                "Id": "5",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "2",
                "ObjectId": "1"
              },
              {
                "Id": "6",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "2",
                "ObjectId": "1"
              }
            ]
          },
          {
            "Id": "3",
            "vQuestName": "Test C",
            "vPacketId": "1",
            "vPartnerId": "1",
            "vAnimationId": "1",
            "UnlockPoint": "500",
            "vCreateDate": null,
            "Condition": [
              {
                "Id": "7",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "3",
                "ObjectId": "1"
              },
              {
                "Id": "8",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "3",
                "ObjectId": "1"
              },
              {
                "Id": "9",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "3",
                "ObjectId": "1"
              }
            ]
          }
        ]
      },
      {
        "Id": "2",
        "Title": "Ha Noi",
        "ImageURL": "http://mytempbucket.s3.amazonaws.com/1398069259.jpg",
        "Quests": [
          {
            "Id": "4",
            "vQuestName": "Test D",
            "vPacketId": "2",
            "vPartnerId": "1",
            "vAnimationId": "1",
            "UnlockPoint": "1000",
            "vCreateDate": null,
            "Condition": [
              {
                "Id": "10",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "4",
                "ObjectId": "1"
              },
              {
                "Id": "11",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "4",
                "ObjectId": "1"
              },
              {
                "Id": "12",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "4",
                "ObjectId": "1"
              }
            ]
          },
          {
            "Id": "5",
            "vQuestName": "Test E",
            "vPacketId": "2",
            "vPartnerId": "1",
            "vAnimationId": "1",
            "UnlockPoint": "1000",
            "vCreateDate": null,
            "Condition": [
              {
                "Id": "13",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "5",
                "ObjectId": "1"
              },
              {
                "Id": "14",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "5",
                "ObjectId": "1"
              },
              {
                "Id": "15",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "5",
                "ObjectId": "1"
              }
            ]
          },
          {
            "Id": "6",
            "vQuestName": "Test F",
            "vPacketId": "2",
            "vPartnerId": "1",
            "vAnimationId": "1",
            "UnlockPoint": "1000",
            "vCreateDate": null,
            "Condition": [
              {
                "Id": "16",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "6",
                "ObjectId": "1"
              },
              {
                "Id": "17",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "6",
                "ObjectId": "1"
              },
              {
                "Id": "18",
                "Type": "1",
                "Value": "1",
                "cVirtualQuestId": "6",
                "ObjectId": "1"
              }
            ]
          }
        ]
      },
      {
        "Id": "1",
        "Title": "Ho Chi Minh City",
        "ImageURL": "http://mytempbucket.s3.amazonaws.com/1398069259.jpg",
        "Quests": [
          {
            "Id": "10",
            "vQuestName": "Heal the world",
            "vPacketId": "1",
            "vPartnerId": "5",
            "vAnimationId": "1",
            "UnlockPoint": "500",
            "vCreateDate": "2014-05-05 07:31:44",
            "Condition": [
              {
                "Id": "22",
                "Type": "0",
                "Value": null,
                "cVirtualQuestId": "10",
                "ObjectId": "5"
              },
              {
                "Id": "23",
                "Type": "1",
                "Value": null,
                "cVirtualQuestId": "10",
                "ObjectId": "12"
              },
              {
                "Id": "24",
                "Type": "1",
                "Value": null,
                "cVirtualQuestId": "10",
                "ObjectId": "18"
              },
              {
                "Id": "25",
                "Type": "1",
                "Value": null,
                "cVirtualQuestId": "10",
                "ObjectId": "17"
              },
              {
                "Id": "26",
                "Type": "2",
                "Value": null,
                "cVirtualQuestId": "10",
                "ObjectId": "12"
              },
              {
                "Id": "27",
                "Type": "2",
                "Value": null,
                "cVirtualQuestId": "10",
                "ObjectId": "22"
              }
            ]
          }
        ]
      }
    ]
  }
}
```