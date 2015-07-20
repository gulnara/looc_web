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