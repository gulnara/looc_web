looc web app
=========

This is the web end point for the mobile app Looc

The web app lives here:
https://quiet-plateau-6449.herokuapp.com/


**To get data for a specific category**

Endpoint: `/data/<category>`

Authorization header required:  

```
access_token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoicGV0ZXJrYWlzZXJ0YWxlbnRAZ21haWwuY29tIn0.05cbRebyfjhEutR329jrSimWhgvVU7qX_w_vx-17W5s

```

Method: `get`

Parameters: category


```
curl -i -H "access_token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoicGV0ZXJrYWlzZXJ0YWxlbnRAZ21haWwuY29tIn0.05cbRebyfjhEutR329jrSimWhgvVU7qX_w_vx-17W5s"\
  -X GET http://quiet-plateau-6449.herokuapp.com/data/Animals%20&%20Pets

```

output:

```
{
   "data":[
      {
         "created_at":"2015-06-24T15:33:06.105Z",
         "id":"558acdb2ad25b10003000001",
         "main_categories":[
            "Animals \u0026 Pets",
            "Technology"
         ],
         "pic_name":"Duck",
         "pic_url":"https://loocdata1.s3.amazonaws.com/2015-06-2415%3A31%3A07%2B0000rubber-duck_0.jpg",
         "question0":{
            "Q":"question 1",
            "CorrectAnswer":5,
            "A":[
               "answer 1",
               "answer 2",
               "an 3",
               "an 4",
               "an 5"
            ]
         },
         "question1":{
            "Q":"q 2",
            "CorrectAnswer":2,
            "A":[
               "an 1",
               "an 2",
               "an 3",
               "an 4",
               "an 5"
            ]
         },
         "question2":{
            "Q":"q 3",
            "CorrectAnswer":5,
            "A":[
               "a 1",
               "a 2",
               "a 3",
               "a 4",
               "a 5"
            ]
         },
         "question3":{
            "Q":"q 4",
            "CorrectAnswer":4,
            "A":[
               "a 1",
               "a 2",
               "a 3",
               "a 4",
               "a 5"
            ]
         },
         "question4":{
            "Q":"q5",
            "CorrectAnswer":2,
            "A":[
               "a1",
               "a 2",
               "a 3",
               "a 4",
               "a 5"
            ]
         },
         "question5":{
            "Q":"q 6",
            "CorrectAnswer":1,
            "A":[
               "a 1",
               "a 2",
               "a 3",
               "a 4",
               "a 5"
            ]
         },
         "sub_categories":[
            "Food \u0026 Drink"
         ],
         "updated_at":"2015-06-24T15:33:06.105Z"
      }
   ]
}
```

**To get the summary of how many questions in each category**

Endpoint: `/count`

Authorization header required:  

```
access_token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoicGV0ZXJrYWlzZXJ0YWxlbnRAZ21haWwuY29tIn0.05cbRebyfjhEutR329jrSimWhgvVU7qX_w_vx-17W5s

```

Method: `get`

Parameters: none


```
curl -i -H "access_token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoicGV0ZXJrYWlzZXJ0YWxlbnRAZ21haWwuY29tIn0.05cbRebyfjhEutR329jrSimWhgvVU7qX_w_vx-17W5s"\
  -X GET http://quiet-plateau-6449.herokuapp.com/count

```

output:

```
{"count":
   {
      "Medicine & Science":2,
      "Transportation":1,
      "Animals & Pets":2,
      "Lifestyle":1,
      "Illustrations & Vector Art":1
   }
}
```


**To get random 6 categories with a single question in each**

Endpoint: `/random`

Authorization header required:  

```
access_token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoicGV0ZXJrYWlzZXJ0YWxlbnRAZ21haWwuY29tIn0.05cbRebyfjhEutR329jrSimWhgvVU7qX_w_vx-17W5s

```

Method: `get`

Parameters: none


```
curl -i -H "access_token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoicGV0ZXJrYWlzZXJ0YWxlbnRAZ21haWwuY29tIn0.05cbRebyfjhEutR329jrSimWhgvVU7qX_w_vx-17W5s"\
  -X GET http://quiet-plateau-6449.herokuapp.com/random

```

output:

```
{
    "random_data": [
        {
            "created_at": "2015-06-26T14:40:37.877Z",
            "id": "558d64652631f80003000001",
            "main_categories": [
                "Animals & Pets"
            ],
            "pic_name": "happy dog",
            "pic_url": "https://loocdata1.s3.amazonaws.com/2015-06-2614%3A38%3A57%2B0000happy-dog-running-by-500px.jpg",
            "question0": {
                "Q": "1",
                "CorrectAnswer": 1,
                "A": [
                    "1",
                    "1",
                    "1",
                    "1",
                    "1"
                ]
            },
            "question1": {
                "Q": "2",
                "CorrectAnswer": 2,
                "A": [
                    "2",
                    "2",
                    "2",
                    "2",
                    "2"
                ]
            },
            "question2": {
                "Q": "3",
                "CorrectAnswer": 3,
                "A": [
                    "3",
                    "3",
                    "3",
                    "3",
                    "3"
                ]
            },
            "question3": {
                "Q": "4",
                "CorrectAnswer": 4,
                "A": [
                    "4",
                    "4",
                    "4",
                    "4",
                    "4"
                ]
            },
            "question4": {
                "Q": "5",
                "CorrectAnswer": 5,
                "A": [
                    "5",
                    "5",
                    "5",
                    "5",
                    "5"
                ]
            },
            "question5": {
                "Q": "6",
                "CorrectAnswer": 2,
                "A": [
                    "6",
                    "6",
                    "6",
                    "6",
                    "6"
                ]
            },
            "sub_categories": [
                "Animals & Pets"
            ],
            "updated_at": "2015-06-26T14:40:37.877Z"
        },
        {
            "created_at": "2015-07-09T22:56:39.711Z",
            "id": "559efc274a727a0003000002",
            "main_categories": [
                "Illustrations & Vector Art"
            ],
            "pic_name": "stuff",
            "pic_url": "https://loocdata1.s3.amazonaws.com/2015-07-0922%3A55%3A09%2B0000download.jpeg",
            "question0": {
                "Q": "1",
                "CorrectAnswer": 1,
                "A": [
                    "111",
                    "1",
                    "1",
                    "1",
                    "1"
                ]
            },
            "question1": {
                "Q": "2",
                "CorrectAnswer": 2,
                "A": [
                    "2",
                    "2",
                    "2",
                    "2",
                    "2"
                ]
            },
            "question2": {
                "Q": "3",
                "CorrectAnswer": 3,
                "A": [
                    "3",
                    "3",
                    "3",
                    "3",
                    "3"
                ]
            },
            "question3": {
                "Q": "4",
                "CorrectAnswer": 4,
                "A": [
                    "4",
                    "4",
                    "4",
                    "4q",
                    "4"
                ]
            },
            "question4": {
                "Q": "5",
                "CorrectAnswer": 5,
                "A": [
                    "5",
                    "5",
                    "5",
                    "5",
                    "5"
                ]
            },
            "question5": {
                "Q": "6",
                "CorrectAnswer": 1,
                "A": [
                    "6",
                    "6",
                    "6",
                    "6",
                    "6"
                ]
            },
            "sub_categories": [
                "Illustrations & Vector Art"
            ],
            "updated_at": "2015-07-09T22:56:39.711Z"
        },
        {
            "created_at": "2015-07-24T18:44:07.841Z",
            "id": "55b28777aeeb0f0003000001",
            "main_categories": [
                "Nature"
            ],
            "pic_name": "robot",
            "pic_url": "https://loocdata1.s3.amazonaws.com/2015-07-2418%3A42%3A50%2B0000robot.jpg",
            "question0": {
                "Q": "test",
                "CorrectAnswer": 1,
                "A": [
                    "test",
                    "test",
                    "test",
                    "tes",
                    "ts"
                ]
            },
            "question1": {
                "Q": "test",
                "CorrectAnswer": 1,
                "A": [
                    "ts",
                    "sds",
                    "asdf",
                    "ad",
                    "asd"
                ]
            },
            "question2": {
                "Q": "dsa",
                "CorrectAnswer": 1,
                "A": [
                    "asd",
                    "ads",
                    "da",
                    "da",
                    "das"
                ]
            },
            "question3": {
                "Q": "ads",
                "CorrectAnswer": 3,
                "A": [
                    "asd",
                    "ads",
                    "ds",
                    "ads",
                    "dsa"
                ]
            },
            "question4": {
                "Q": "ads",
                "CorrectAnswer": 5,
                "A": [
                    "asd",
                    "ads",
                    "das",
                    "ds",
                    "sd"
                ]
            },
            "question5": {
                "Q": "ddsa",
                "CorrectAnswer": 1,
                "A": [
                    "ds",
                    "das",
                    "ads",
                    "ads",
                    "ad"
                ]
            },
            "sub_categories": [
                "Business"
            ],
            "updated_at": "2015-07-24T18:44:07.841Z"
        },
        {
            "created_at": "2015-06-26T04:24:48.835Z",
            "id": "558cd41091425e0003000001",
            "main_categories": [
                "Medicine & Science",
                "Transportation"
            ],
            "pic_name": "test ",
            "pic_url": "https://loocdata1.s3.amazonaws.com/2015-06-2604%3A23%3A43%2B0000rubber-duck_0.jpg",
            "question0": {
                "Q": "test",
                "CorrectAnswer": 5,
                "A": [
                    "test",
                    "test",
                    "test",
                    "test",
                    "test"
                ]
            },
            "question1": {
                "Q": "test",
                "CorrectAnswer": 1,
                "A": [
                    "test",
                    "test",
                    "test",
                    "test",
                    "test"
                ]
            },
            "question2": {
                "Q": "test",
                "CorrectAnswer": 5,
                "A": [
                    "test",
                    "test",
                    "test",
                    "test",
                    "test"
                ]
            },
            "question3": {
                "Q": "test",
                "CorrectAnswer": 5,
                "A": [
                    "test",
                    "test",
                    "test",
                    "test",
                    "test"
                ]
            },
            "question4": {
                "Q": "test",
                "CorrectAnswer": 5,
                "A": [
                    "test",
                    "test",
                    "test",
                    "test",
                    "test"
                ]
            },
            "question5": {
                "Q": "test",
                "CorrectAnswer": 5,
                "A": [
                    "test",
                    "test",
                    "test",
                    "test",
                    "test"
                ]
            },
            "sub_categories": [
                "Animals & Pets",
                "Arts & Entertainment"
            ],
            "updated_at": "2015-06-26T04:24:48.835Z"
        },
        {
            "created_at": "2015-07-07T16:46:23.716Z",
            "id": "559c025f835ce60003000002",
            "main_categories": [
                "Medicine & Science"
            ],
            "pic_name": "Books",
            "pic_url": "https://loocdata1.s3.amazonaws.com/2015-07-0716%3A45%3A20%2B0000photo-1423592707957-3b212afa6733.jpeg",
            "question0": {
                "Q": "1",
                "CorrectAnswer": 1,
                "A": [
                    "1",
                    "1",
                    "1",
                    "1",
                    "1"
                ]
            },
            "question1": {
                "Q": "2",
                "CorrectAnswer": 2,
                "A": [
                    "2",
                    "2",
                    "2",
                    "2",
                    "2"
                ]
            },
            "question2": {
                "Q": "3",
                "CorrectAnswer": 3,
                "A": [
                    "3",
                    "3",
                    "3",
                    "3",
                    "3"
                ]
            },
            "question3": {
                "Q": "4",
                "CorrectAnswer": 4,
                "A": [
                    "4",
                    "4",
                    "4",
                    "4",
                    "4"
                ]
            },
            "question4": {
                "Q": "5",
                "CorrectAnswer": 5,
                "A": [
                    "5",
                    "5",
                    "5",
                    "5",
                    "5"
                ]
            },
            "question5": {
                "Q": "6",
                "CorrectAnswer": 5,
                "A": [
                    "6",
                    "6",
                    "6",
                    "6",
                    "6"
                ]
            },
            "sub_categories": [
                "Medicine & Science"
            ],
            "updated_at": "2015-07-07T16:46:23.716Z"
        },
        {
            "created_at": "2015-07-09T22:01:51.439Z",
            "id": "559eef4f4a727a0003000001",
            "main_categories": [
                "Lifestyle"
            ],
            "pic_name": "mountain",
            "pic_url": "https://loocdata1.s3.amazonaws.com/2015-07-0922%3A00%3A32%2B0000download1.JPG",
            "question0": {
                "Q": "1",
                "CorrectAnswer": 1,
                "A": [
                    "1",
                    "1",
                    "1",
                    "1",
                    "1"
                ]
            },
            "question1": {
                "Q": "2",
                "CorrectAnswer": 2,
                "A": [
                    "2",
                    "2",
                    "2",
                    "2",
                    "2"
                ]
            },
            "question2": {
                "Q": "3",
                "CorrectAnswer": 3,
                "A": [
                    "3",
                    "3",
                    "3",
                    "3",
                    "3"
                ]
            },
            "question3": {
                "Q": "4",
                "CorrectAnswer": 4,
                "A": [
                    "4",
                    "4",
                    "4",
                    "4",
                    "4"
                ]
            },
            "question4": {
                "Q": "5",
                "CorrectAnswer": 5,
                "A": [
                    "5",
                    "5",
                    "5",
                    "5",
                    "5"
                ]
            },
            "question5": {
                "Q": "6",
                "CorrectAnswer": 1,
                "A": [
                    "1",
                    "1",
                    "1",
                    "1",
                    "1"
                ]
            },
            "sub_categories": [
                "Lifestyle"
            ],
            "updated_at": "2015-07-09T22:01:51.439Z"
        }
    ]
}
```