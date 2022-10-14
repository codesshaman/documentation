# Chat json for fronend

## Groups

Name | Create Group
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/group
Type	|   Post
Form-data	|   group_name : "droup1"
. |user_id[] : 3
. |user_id[] : 4

---

Name | Get Users In Group By Id
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/group/{group_id}
Type	|   Get

Response:
```
{
    "data": [
        {
            "id": 9,
            "group_name": "test Group 4",
            "group_id": 4,
            "user_id": 3,
            "user_name": "cccc",
            "join_at": "2022-07-05T09:34:12.000000Z"
        },
    ]
}
```

---

Name | Get All Groups For Admin
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/group
Type	|   Get

Response:
```
{
    "data": [
        {
            "id": 1,
            "group_name": "test Group",
            "user_id": 4,
            "user_name": "aaa",
            "users_count": 3,
            "created_at": "2022-07-05T09:33:14.000000Z"
        },
    ]
}
```
---

Name | Get All Group For User login
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/groupForUser
Type	|   Get

Response:
```
{
    "data": [
        {
            "id": 2,
            "group_name": "test Group 2",
            "user_id": 4,
            "user_name": "aaa",
            "users_count": 3,
            "created_at": "2022-07-05T09:33:59.000000Z"
        }
    ]
}
```

---

Name | Update Group
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/group
Type	|   Put
Form-data	|   group_id : 6
. | group_name : test 2
. | user_id[] : 5
. | user_id[] : 6

---

Name | 	Delete Group
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/group
Type	|   Delete
Form-data	|   group_id : 6

---

# Messages

Name | Send message PtP
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/message
Type	|   Post
Form-data	|   content : "test 3 xx d"
. | receiver_id : 3 {user_id}
. | files[] : optional

---

Name | 	Delete All Messages For User
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/message
Type	|   Delete
Form-data	|   receiver_id : 6 {user_id}

---

Name | 	Delete OneMessageForUser
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/del_message
Type	|   Delete
Form-data	|   message_id: 6

---

Name | 	Delete All Messages From Group
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/message_group
Type	|   Delete
Form-data	|   group_id : 6

---

Name | 	Delete One Message From Group
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/del_message_group
Type	|   Delete
Form-data	|   message_id : 6

---

Name | Get Messages For User By Id
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/groupForUser
Type	|   Get

Response:
```
{
    "data": [
        {
            "id": 18,
            "content": "test 4 msg ptp aaa",
            "user_id": 4,
            "sender_name": "Я",
            "receiver_id": 4,
            "receiver_name": "Я",
            "type": "file",
            "send_timestamp": 1657107342,
            "read_at": "11 minutes ago"
        }
    ],
    "links": {
        "first": "http://127.0.0.1:8000/api/auth/chats/message/4?page=1",
        "last": "http://127.0.0.1:8000/api/auth/chats/message/4?page=1",
        "prev": null,
        "next": null
    },
    "meta": {
        "current_page": 1,
        "from": 1,
        "last_page": 1,
        "links": [
            {
                "url": null,
                "label": "&laquo; Previous",
                "active": false
            },
            {
                "url": "http://127.0.0.1:8000/api/auth/chats/message/4?page=1",
                "label": "1",
                "active": true
            },
            {
                "url": null,
                "label": "Next &raquo;",
                "active": false
            }
        ],
        "path": "http://127.0.0.1:8000/api/auth/chats/message/4",
        "per_page": 25,
        "to": 1,
        "total": 1
    }
}
```

---

Name | 	Get All Messages With Another Users
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/message
Type	|   Get

Response:
```
{
    "data": [
        {
            "receiver_id": 3,
            "user_id": 4,
            "receiver_name": "cccc",
            "unread_msg": 0
        },
        {
            "receiver_id": 4,
            "user_id": 4,
            "receiver_name": "Я",
            "unread_msg": 0
        },
        {
            "receiver_id": 5,
            "user_id": 4,
            "receiver_name": "bbb",
            "unread_msg": 50
        }
    ]
}
```

---

Name | 	Get Messages For User In Group By group_Id
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/message_group/{group_id}
Type	|   Get

Response:
```
{
    "data": [
        {
            "id": 26,
            "content": "test msg to group 1",
            "user_id": 4,
            "sender_name": "aaa",
            "receiver_id": 1,
            "receiver_name": "test Group",
            "type": "text",
            "send_timestamp": 1657016908,
            "reading_id": null,
            "read_at": "23 hours ago"
        },
    ],
    "links": {
        "first": "http://127.0.0.1:8000/api/auth/chats/message_group/1?page=1",
        "last": "http://127.0.0.1:8000/api/auth/chats/message_group/1?page=1",
        "prev": null,
        "next": null
    },
    "meta": {
        "current_page": 1,
        "from": 1,
        "last_page": 1,
        "links": [
            {
                "url": null,
                "label": "&laquo; Previous",
                "active": false
            },
            {
                "url": "http://127.0.0.1:8000/api/auth/chats/message_group/1?page=1",
                "label": "1",
                "active": true
            },
            {
                "url": null,
                "label": "Next &raquo;",
                "active": false
            }
        ],
        "path": "http://127.0.0.1:8000/api/auth/chats/message_group/1",
        "per_page": 25,
        "to": 1,
        "total": 1
    }
}
```

---

Name | Send Message to Group By group_Id
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/message_group/{group_Id}
Type	|   Post
Form-data	|   content : "test 3 xx d"
. | files[] : optional

---

Name | 	Read Meesages
------ | ------
Url     |   http://127.0.0.1:8000/api/auth/chats/read
Type	|   Post
Form-data	|   receiver_id : 5 {group_Id Or user_id}
. | is_group : 0 Or 1

---