# aptm

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## API

# aptm-backend

## Introduction

This api can be used with any type of project that needs a dashboard api. you can use examples below to check how this api works and feel free to enjoy it in your awesome projects.

**_If sever found an error or something is invalid, it's going to retur this json_**

```
    {
      "success": false,
      "msg": "**Error Message***"
    }
```

### **Home** Route

1. Accessing **get home** route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com')
          .then(res=>res.json())
          .then(json=>console.log(json))
```

> response
`` {
    "success": true,
    "msg": "Welcome from aptm api !"
  }
``

### **Auth** Route

1. Accessing **register** route

> code sample

```
  const data = {
      name: "",
      email: " ",
      password: " ",
      phone: " ",
      role: "super admin, admin, user", // (default user)
      dob: "",// (YY/MM/DD)
      profileImage: "",
      deviceId: "",// for push notification
      token: "", // for push notification
  };
  fetch('https://aptm-b.ethical-digit.com/auth/register', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
  });
```

> response
 ``

    {
      success: true,
      data: { ... },
      token: "Bearer ....",
      expires: "7d"
    }

``

**_<br />You can only have one account with a single email._**<br /><br />
**Email Validation**

- must include @ (mysite.ourearth.com)
- tld (Top Level domain) can not start with dot "." (mysite@.com.my)
- must include character before @ (@you.me.net)
- ".b" is not a valid tld (mysite123@gmail.b)
- tld can not start with dot "." (mysite@.org.org)
- an email should not be start with "." (.mysite@mysite.org)
- mysite()_@gmail.com [ here the regular expression only allows character, digit, underscore, and dash ] (mysite()_@gmail.com)
- double dots are not allowed (mysite..1234@yahoo.com)

2. Accessing **thrid party login** route
   > code sample

```
  const data = {
      email: "",// (optional)
      name: "",
      thirdParty: "google or facebook",
      thirdPartyToken: "",
      phone: "", // (optional)
      token: "", // for push notification
      deviceId: "", // for push notification
  };
  fetch('https://aptm-b.ethical-digit.com/auth/thirdPartyLogin', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
  });
```

> response
``
  {
    success: true,
    data: { ... },
    token: "Bearer ....",
    expires: "7d"
  }
``

3. Accessing **login** route
   > code sample

```
  const data = {
      email: "",
      password: "",
      token: "", // for push notification
      deviceId: "", // for push notification
  };
  fetch('https://aptm-b.ethical-digit.com/auth/login', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
  });
```

> response
``
  {
    success: true,
    data: { ... },
    token: "Bearer ....",
    expires: "7d"
  }
``

4. Accessing **dashboard login** route
   > code sample

```
  const data = {
      email,
      password,
  };
  fetch('https://aptm-b.ethical-digit.com/auth/dashboardLogin', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
  });
```

> response
 ``

    {
      success: true,
      data: { ... },
      token: "Bearer ....",
      expires: "7d"
    }

``



---

### **Users** Route

1. Accessing **create user** Route

> code sample

```
  const data = {
      name: "",
      email: " ",
      password: " ",
      phone: " ",
      role: "super admin, admin, user", // (default user)
      dob: "",// (YY/MM/DD)
      profileImage: ""
  };
  fetch('https://aptm-b.ethical-digit.com/users', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      },
      body: JSON.stringify(data),
  });
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />
If you want to make the roles with the select box or radio buttons you can get all the roles from **Roles** Route by accessing the **getAllRole**.

> response
 ``

    {
      success: true,
      msg: `User with the email of ${user.email} has been created successfully !`
    }

``

2. Accessing **get all user** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/users', {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />
You can use the ways that are shown below to filter the users.

- To limit how many user per page<br />

```
    fetch('https://aptm-b.ethical-digit.com/users?userPerPage=**number of user per page**');
```

- To set which page<br />

```
    fetch('https://aptm-b.ethical-digit.com/users?page=**page number**');
```

- To filter by both name and email<br />

```
    fetch('https://aptm-b.ethical-digit.com/users?search=**search word**');
```

- To filter by name<br />

```
    fetch('https://aptm-b.ethical-digit.com/users?name=**name**');
```

- To filter by email<br />

```
    fetch('https://aptm-b.ethical-digit.com/users?email=**email**');
```

- To filter by phone number<br />

```
    fetch('https://aptm-b.ethical-digit.com/users?phone=**phone number**');
```

- To filter by role<br />

```
    fetch('https://aptm-b.ethical-digit.com/users?role=**role**');
```

- To filter between start Date and end Date<br />

```
    fetch('https://aptm-b.ethical-digit.com/users?startDate=**year-month-day**&endDate=**year-month-day**');
```

- To filter users after start Date <br />

```
    fetch('https://aptm-b.ethical-digit.com/users?startDate=**year-month-day**');
```

- To filter users before end Date <br />

```
    fetch('https://aptm-b.ethical-digit.com/users?endDate=**year-month-day**');
```

- To sort users with the date of creation <br />

```
    fetch('https://aptm-b.ethical-digit.com/users?sort=createdAt');
```

- To sort users with the date of updation <br />

```
    fetch('https://aptm-b.ethical-digit.com/users?sort=updatedAt');
```

- To sort users with from A to Z <br />

```
    fetch('https://aptm-b.ethical-digit.com/users?sort=a_to_z');
```

- To sort users with from Z to A <br />

```
    fetch('https://aptm-b.ethical-digit.com/users?sort=z_to_a');
```

- To sort users with from Z to A <br />

```
    fetch('https://aptm-b.ethical-digit.com/users?sort=z_to_a');
```

> response
 ``

    {
        success: true,
        total_results: 5,
        found_results: 4,
        page: 0,
        entries_per_page: 20,
        users: [ {...}, {...}, {...}, {...} ]
    }

``

3. Accessing **get single user** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/users/:id', {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
 ``

    {
      success: true,
      user: { ... }
    }

``

4. Accessing **update user** Route

> code sample

```
  const data = {
      name,
      email,
      phone,
      password,
      role,
      profileImage
  };
  fetch('https://aptm-b.ethical-digit.com/users/:id', {
      method: 'PATCH',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      },
      body: JSON.stringify(data),
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />
Put any property you want to update about the user in the request body.

> response
 ``

    {
      "success": true,
      "msg": "User with the id of **id** has been updated !"
    }

``

5. Accessing **delete user** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/users/:id', {
      method: 'DELETE',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
 ``

    {
      "success": true,
      "msg": "User with the id of **:id** has been deleted !"
    }

``

---

### **Roles** Route

1. Accessing **create role** Route

```
  const data = {
    "role": "admin",
    "permissions": {
        "overUser": {
            "createUser": true or false,
            "getUser": true or false,
            "updateUser": true or false,
            "deleteUser": true or false
        },
        "overRole": {
            "createRole": true or false,
            "getRole": true or false,
            "updateRole": true or false,
            "deleteRole": true or false
        },
        "overPackage": {
            "createPackage": true or false,
            "getPackage": true or false,
            "updatePackage": true or false,
            "deletePackage": true or false
        },
        "overBook": {
            "createBook": true or false,
            "getBook": true or false,
            "updateBook": true or false,
            "deleteBook": true or false
        },
        "overAudio": {
            "createAudio": true or false,
            "getAudio": true or false,
            "updateAudio": true or false,
            "deleteAudio": true or false
        },
        "overVideo": {
            "createVideo": true or false,
            "getVideo": true or false,
            "updateVideo": true or false,
            "deleteVideo": true or false
        }
      }
  };
  fetch('https://aptm-b.ethical-digit.com/roles', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      },
      body: JSON.stringify(data),
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
 ``

    {
      "success": true,
      "msg": "Role called **role** has been added !"
    }

``

2. Accessing **get single role** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/roles/:id', {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json',
          'Authorization: 'Bearer **TOKEN**'
      },
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
 ``

    {
    "success": true,
    "role": { ... }

}
``

3. Accessing **get all role** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/roles', {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json',
          'Authorization: 'Bearer **TOKEN**'
      },
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
 ``

    {
      "success": true,
      "roles": [ {...}, {...}, {...}, {...} ]
    }

``

4. Accessing **update role** Route

> code sample

```
  const data = {
    "role": "admin",
    "permissions": {
            "createUser": true or false,
            "getUser": true or false,
            "getAllUser": true or false,
            "updateUser": true or false,
            "deleteRole": true or false,
            // or other permissions
        }
      }
  };
  fetch('https://aptm-b.ethical-digit.com/roles/:id', {
      method: 'PATCH',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      },
      body: JSON.stringify(data),
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />
**And also only add the **permissions** in the permissions object of request body.** <br />

> response
 ``

    {
      "success": true,
      "roles": "Role with the id of **id** has been updated !"
    }

``

5.  Accessing **delete role** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/roles/:id', {
      method: 'DELETE',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      },
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
 ``

    {
      "success": true,
      "roles": "Role with the id of **id** has been deleted!"
    }

``

---

### **OTP** Route for _forget password_

1. Accessing **send email** Route

```
  const data = {
    email: "example@gmail.com"
  };
  fetch('https://aptm-b.ethical-digit.com/otp/send_email', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

The server will send the otp that expires in 1 day to the user email.

**_Store the email that user enter in localStorage or something you use to store data.<br /> You need to send back both the otp and email in varify otp route._** <br />

> response
``
  {
    "success": true,
    "msg": "Check your email !"
  }
``

2. Accessing **varify otp** Route

```
  const data = {
    "opt": " **OTP** ",
    "email": "example@gmail.com"
  };
  fetch('https://aptm-b.ethical-digit.com/otp/varify_email', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**_After successful varification redirect the user to the route to reset the password.<br /> You need to send back both the new password and email in change password route._** <br />

> response
 ``

    {
      "success": true,
      "msg": "OTP varification successfull !"
    }

``

3. Accessing **change password** Route

```
  const data = {
    "password": " **password** ",
    "email": "example@gmail.com"
  };
  fetch('https://aptm-b.ethical-digit.com/otp/change_password', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**_After changing successfully password, redirect the user to the login route to login._**

> response
 ``

    {
      "success": true,
      "msg": "User with the email of **email** has successfully changed the password !"
    }

## ``

### **Books** Route

1. Accessing **create Book** Route

> code sample

```

  let form = document.getElementById('form');

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    var formData = new FormData(form);

    // in formData = {
    //   title: titleInput.value,
    //   author: authorInput.value,
    //   description: descriptionInput.value,
    //   coverPhoto: coverPhotoInput.value,
    //   file: pdfInput.files[0].name,
    //   category: genresInput.value,
    //   rating: rating, // number or decimal
    // }


    fetch(`https://aptm-b.ethical-digit.com/books`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        Authorization: "Bearer **Token**"
      },
      body: formData,
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
  })
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />
If you want to call the categories of the books you can get all that from accessing the **categories**.

> response
 ``

    {
      success: true,
      msg: `Book with the title of ${Book.title} has been created successfully !`
    }

``



2. Accessing **get all Books** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/books', {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />
You can use the ways that are shown below to filter the books.

- To limit how many book per page<br />

```
    fetch('https://aptm-b.ethical-digit.com/books?bookPerPage=**number of book per page**');
```

- To set which page<br />

```
    fetch('https://aptm-b.ethical-digit.com/books?page=**page number**');
```

- To filter by title, author and packagePlan<br />

```
    fetch('https://aptm-b.ethical-digit.com/books?search=**title, author or packagePlan**');
```

- To filter by title<br />

```
    fetch('https://aptm-b.ethical-digit.com/books?title=**title**');
```

- To filter by author<br />

```
    fetch('https://aptm-b.ethical-digit.com/books?author=**author**');
```

- To filter by category<br />

```
    fetch('https://aptm-b.ethical-digit.com/books?category=**category**');
```

- To filter by add category<br />

```
    fetch('https://aptm-b.ethical-digit.com/books?category=addon');
```
> response
``
  {
      success: true,
      addons: [{...}, {...}, {...}]
  }
``

- To filter by rating<br />

```
    fetch('https://aptm-b.ethical-digit.com/books?rating=**rating**'); // greater than the **rating**
```

- To sort books from A to Z <br />

```
    fetch('https://aptm-b.ethical-digit.com/books?sort=a_to_z');
```

- To sort books from Z to A <br />

```
    fetch('https://aptm-b.ethical-digit.com/books?sort=z_to_a');
```

- To sort books from latest creation <br />

```
    fetch('https://aptm-b.ethical-digit.com/books?sort=createdAt');
```

- To sort books from latest updation <br />

```
    fetch('https://aptm-b.ethical-digit.com/books?sort=updatedAt');
```

> response
``
  {
      success: true,
      total_results: 5,
      found_results: 4,
      page: 0,
      entries_per_page: 20,
      books: [ {...}, {...}, {...}, {...} ],
      addonBooks: [{...}, {...}]
  }
``

3. Accessing **get single Book** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/books/:id', {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
 ``

    {
      success: true,
      book: { ... }
    }

``

4. Accessing **update Book** Route

> code sample

```
  let form = document.getElementById('form');

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    var formData = new FormData(form);

    // in formData = {
    //   title: titleInput.value,
    //   file: pdfInput.files[0].name,
    //   category: genresInput.value,
    // }


    fetch(`https://aptm-b.ethical-digit.com/books/:id`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        Authorization: "Bearer **Token**"
      },
      body: formData,
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
  })
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

If you want to call the categories of the books you can get all the that from accessing the **categories**.
Put any property you want to update about the Book in the request body.

> response
 ``

    {
      "success": true,
      "msg": "Book with the id of **id** has been updated !"
    }

``

5. Accessing **delete Book** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/books/:id', {
      method: 'DELETE',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
 ``

    {
      "success": true,
      "msg": "Book with the id of **id** has been deleted !"
    }

``

6.  Accessing **add or remove the favorite book or video or audio** Route

> code sample

```
  // ' :id ' is the book or audio or video id
  fetch('https://aptm-b.ethical-digit.com/books(or videos or audios)/:id/favorite', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />
**If the user called the api for the first time his id will be push to the favorite array of the book (or audio or video) and at the second time his id in the favorite array will be poped out. Book id will also be added to the user favorite list or removed from it.** <br />

> response
 ``

    {
      "success": true,
      "msg": "Successfully add (or remove) favorite the book (or audio or video) !"
    }

``

7.  Accessing **add or remove the book or video or audio download** Route

> code sample

```
  // ' :id ' is the book or audio or video id
  fetch('https://aptm-b.ethical-digit.com/books(or videos or audios)/:id/download', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />
**If the user called the api, his id will be push to the download array of the book (or audio or video). Book id will also be added to the user download list or removed from it.** <br />

> response
``
 {
    "success": true,
    "msg": "Successfully add (or remove) download the book (or audio or video) !"
  }
``

8.  Accessing **add the book or video or audio read count** Route

> code sample

```
  // ' :id ' is the book or audio or video id
  fetch('https://aptm-b.ethical-digit.com/books(or videos or audios)/:id/read', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />
**If the user called the api, his id will be push to the read array of the book (or audio or video).** <br />

> response
 ``

    {
      "success": true,
      "msg": "Successfully add (or remove) read the book (or audio or video) !"
    }

``

9.  Accessing **rate the book or video or audio read** Route

> code sample

```
  // ' :id ' is the book or audio or video id
  let data = {
    rating: 1.5 // or 0 or a floating number
  }

  fetch('https://aptm-b.ethical-digit.com/books(or videos or audios)/:id/rating', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      },
      body: JSON.stringify(data)
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
 ``

    {
      "success": true,
      "msg": "Successfully add (or remove) read the book (or audio or video) !"
    }

``
---

### **Audios** Route

1. Accessing **create Video** Route

> code sample

```

  let form = document.getElementById('form');

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    var formData = new FormData(form);

    // in formData = {
    //   title: titleInput.value,
    //   author: authorInput.value,
    //   duration: durationInput.value,
    //   summary: summaryInput.value,
    //   description: descriptionInput.value,
    //   coverPhoto: coverPhotoInput.value,
    //   file: pdfInput.files[0].name,
    //   category: genresInput.value,
    //   rating: rating, // number or decimal
    // }


    fetch(`https://aptm-b.ethical-digit.com/audios`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        Authorization: "Bearer **Token**"
      },
      body: formData,
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
  })
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />
For the Audios which has two or more **category**, seperated them with **comma** between them.("comedy,novel,...") <br /> **_Don't add spaces before comma or after comma. Data type must be String._** <br /><br />
If you want to call the categories of the Audios you can get all the that from accessing the **categories**.

> response
 ``

    {
      success: true,
      msg: `Audio with the title of ${Audio.title} has been created successfully !`
    }

``

2. Accessing **get all Audio** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/audios', {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />
You can use the ways that are shown below to filter the Audios.

- To limit how many Audio per page<br />

```
    fetch('https://aptm-b.ethical-digit.com/audios?audioPerPage=**number of audio per page**');
```

- To set which page<br />

```
    fetch('https://aptm-b.ethical-digit.com/audios?page=**page number**');
```

- To filter by search<br />

```
    fetch('https://aptm-b.ethical-digit.com/audios?search=**title or author**');
```

- To filter by title<br />

```
    fetch('https://aptm-b.ethical-digit.com/audios?title=**title**');
```

- To filter by author<br />

```
    fetch('https://aptm-b.ethical-digit.com/audios?author=**author**');
```

- To filter by category<br />

```
    fetch('https://aptm-b.ethical-digit.com/audios?category=**category**');
```

- To filter by rating<br />

```
  fetch('https://aptm-b.ethical-digit.com/audios?rating=**rating**'); // greater than the **rating**
```

- To sort Audios from A to Z <br />

```
    fetch('https://aptm-b.ethical-digit.com/audios?sort=a_to_z');
```

- To sort Audios from Z to A <br />

```
    fetch('https://aptm-b.ethical-digit.com/audios?sort=z_to_a');
```

> response
 ``
  {
    success: true,
    total_results: 5,
    found_results: 4,
    page: 0,
    entries_per_page: 20,
    audios: [ {...}, {...}, {...}, {...} ]
  }
``

3. Accessing **get single Audio** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/audios/:id', {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
``
  {
    success: true,
    audio: { ... }
  }
``

4. Accessing **update Audio** Route

> code sample

```
  let form = document.getElementById('form');

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    var formData = new FormData(form);

    // in formData = {
    //   title: titleInput.value,
    //   file: pdfInput.files[0].name,
    //   category: genresInput.value,
    //   summary: summaryInput.value
    // }


    fetch(`https://aptm-b.ethical-digit.com/audios/:id`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        Authorization: "Bearer **Token**"
      },
      body: formData,
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
  })
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.**<br /><br />
If you want to call the categories of the Audios you can get all that from accessing the **categories**.
Put any property you want to update about the Audio in the request body.

> response
``
  {
    "success": true,
    "msg": "Audio with the id of **id** has been updated !"
  }
``

5. Accessing **delete Audio** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/audios/:id', {
      method: 'DELETE',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
 ``

    {
      "success": true,
      "msg": "Audio with the id of **id** has been deleted !"
    }

``

---

### **Videos** Route

1. Accessing **create Video** Route

> code sample

```

  let form = document.getElementById('form');

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    var formData = new FormData(form);

    // in formData = {
    //   title: titleInput.value,
    //   author: authorInput.value,
    //   duration: durationInput.value,
    //   description: descriptionInput.value,
    //   coverPhoto: coverPhotoInput.value,
    //   file: pdfInput.files[0].name,
    //   category: genresInput.value,
    //   rating: rating, // number or decimal
    // }

    fetch(`https://aptm-b.ethical-digit.com/videos`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        Authorization: "Bearer **Token**"
      },
      body: formData,
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
  })
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />
For the Videos which has two or more **category**, seperated them with **comma** between them.("comedy,novel,...") <br /> **_Don't add spaces before comma or after comma. Data type must be String._** <br /><br />
If you want to call the categories of the Videos you can get all the that from accessing the **categories**.

> response
``
  {
    success: true,
    msg: `Video with the title of ${Video.title} has been created successfully !`
  }
``

2. Accessing **get all Video** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/videos', {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />
You can use the ways that are shown below to filter the Videos.

- To limit how many Video per page<br />

```
    fetch('https://aptm-b.ethical-digit.com/videos?audioPerPage=**number of Video per page**');
```

- To set which page<br />

```
    fetch('https://aptm-b.ethical-digit.com/videos?page=**page number**');
```

- To filter by search<br />

```
    fetch('https://aptm-b.ethical-digit.com/videos?search=** title **');
```

- To filter by title<br />

```
    fetch('https://aptm-b.ethical-digit.com/videos?title=**title**');
```

- To filter by author<br />

```
    fetch('https://aptm-b.ethical-digit.com/videos?author=**author**');
```

- To filter by category<br />

```
    fetch('https://aptm-b.ethical-digit.com/videos?category=**category**');
```

- To filter by rating<br />

```
    fetch('https://aptm-b.ethical-digit.com/videos?rating=**rating**'); // greater than the **rating**
```

- To sort Videos from A to Z <br />

```
    fetch('https://aptm-b.ethical-digit.com/videos?sort=a_to_z');
```

- To sort Videos from Z to A <br />

```
    fetch('https://aptm-b.ethical-digit.com/videos?sort=z_to_a');
```

> response
``
  {
    success: true,
    total_results: 5,
    found_results: 4,
    page: 0,
    entries_per_page: 20,
    videos: [ {...}, {...}, {...}, {...} ]
  }
``

3. Accessing **get single Video** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/videos/:id', {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
``
  {
    success: true,
    audio: { ... }
  }
``

4. Accessing **update Video** Route

> code sample

```
  let form = document.getElementById('form');

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    var formData = new FormData(form);

    // in formData = {
    //   title: titleInput.value,
    //   file: pdfInput.files[0].name,
    //   category: genresInput.value,
    // }


    fetch(`https://aptm-b.ethical-digit.com/videos/:id`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        Authorization: "Bearer **Token**"
      },
      body: formData,
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
  })
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />
For the Videos which has two or more **category**, seperated them with **comma** between them.("comedy,novel,...") <br /> **_Don't add spaces before comma or after comma. Data type must be String._** <br /><br />
If you want to call the categories of the Videos you can get all the that from accessing the **categories**.
Put any property you want to update about the Video in the request body.

> response
``
  {
    "success": true,
    "msg": "Video with the id of **id** has been updated !"
  }
`` 

5. Accessing **delete Video** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/videos/:id', {
      method: 'DELETE',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
``
    {
      "success": true,
      "msg": "Video with the id of **id** has been deleted !"
    }
``

---

### **Addon** Route

1. Accessing **create Addon** Route

> code sample

```
  let form = document.getElementById('form');

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    var formData = new FormData(form);

    // in formData = {
    //    "name": "Paul Hawkin",
    //    "price": "1,000,0",
    //    "month": "6",
    //    "description": "Horror and Thriller collections"
    // }

    fetch(`https://aptm-b.ethical-digit.com/addons`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        Authorization: "Bearer **Token**"
      },
      body: formData,
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
  })
```

> response
``
  {
    "success": true,
    "msg": "Addon with the name of **addon name** has been added to the database !"
  }
``


2. Accessing **adding multiple books to an addon** Route

> code sample

```
  const data = {
    addonId: 'addon id',
    bookIds: ['book id', 'book id', 'book id']
  }

  fetch(`https://aptm-b.ethical-digit.com/books/addon`, {
    method: "POST",
    headers: {
      Accept: "application/json",
      Authorization: "Bearer **Token**"
    },
    body: data,
  })
  .then((response) => response.json())
  .then(data => console.log(data))
  .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
``
  {
    success: true,
    msg: "Books with the id of '..., ..., ...' has been updated to the addon with the id of ... !"
  }
``



3. Accessing **get all addon** Route

> code sample

```
  fetch(`https://aptm-b.ethical-digit.com/addons`, {
    method: "GET",
    headers: {
      'Content-Type': "application/json",
      Authorization: "Bearer **Token**"
    }
  })
  .then((response) => response.json())
  .then(data => console.log(data))
  .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

- To limit how many addon per page<br />

```
    fetch('https://aptm-b.ethical-digit.com/addons?addonPerPage=**number of addon per page**');
```

- To set which page<br />

```
    fetch('https://aptm-b.ethical-digit.com/addons?page=**page number**');
```

- To filter by search<br />

```
    fetch('https://aptm-b.ethical-digit.com/addons?search=**name or price**');
```

- To filter by name<br />

```
    fetch('https://aptm-b.ethical-digit.com/addons?name=**name**');
```

- To filter by price<br />

```
    fetch('https://aptm-b.ethical-digit.com/addons?price=**price**');
```

- To sort from A to Z<br />

```
    fetch('https://aptm-b.ethical-digit.com/addons?sort=a_to_z');
```

- To sort from Z to A<br />

```
    fetch('https://aptm-b.ethical-digit.com/addons?sort=z_to_a');
```

- To sort from latest creation<br />

```
    fetch('https://aptm-b.ethical-digit.com/addons?sort=createdAt');
```

- To sort from latest updation<br />

```
    fetch('https://aptm-b.ethical-digit.com/addons?sort=updatedAt');
```

> response 
``
  {
    success: true,
    total_results: 5,
    found_results: 4,
    page: 0,
    entries_per_page: 20,
    addons: { [...], [...], [...] }
  }
``

4. Accessing **get single addon** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/addons/:id', {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
``
  {
    success: true,
    addon: { ... }
  }

``

5. Accessing **update Addon** Route

> code sample

```
  let form = document.getElementById('form');

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    var formData = new FormData(form);

    fetch(`https://aptm-b.ethical-digit.com/addons/:id`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        Authorization: "Bearer **Token**"
      },
      body: formData,
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
  })
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />
Put any property you want to update about the Addons in the request body.

> response
``
  {
    "success": true,
    "msg": "Addon with the id of **id** has been updated !"
  }
`` 
6. Accessing **delete Addon** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/addons/:id', {
      method: 'DELETE',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
``
    {
      "success": true,
      "msg": "Addon with the id of **id** has been deleted !"
    }
``


7. Accessing **purchase Addon** Route

> code sample

```
  let data = {
    addonId: "63ae55da1f4150ac79b1f9d1",
    userId: "63a944452e02d2aa3a5fef79"
  }

  fetch('https://aptm-b.ethical-digit.com/addons/purchase', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      },
      body: JSON.stringify(data)
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

** Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
``
  {
    success: true,
    msg: "Addon purchase successful !"
  }
``



8. Accessing **cancel Addon** Route

> code sample

```
  let data = {
    userId: "63a944452e02d2aa3a5fef79",
    addonId: "63a944452e02d2aa3a5fef79"
  }

  fetch('https://aptm-b.ethical-digit.com/addons/cancel', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      },
      body: JSON.stringify(data)
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

** Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
``
  {
    success: true,
    msg: "You have successfully cancel !"
  }
``

---

### **Package** Route

1. Accessing **create Package** Route

> code sample

```
  let form = document.getElementById('form');

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    var formData = new FormData(form);

    // in formData = {
    //    "name": "Paul Hawkin",
    //    "price": "1,000,0",
    //    "month": "6",
    //    "description": "Horror and Thriller collections"
    // }

    fetch(`https://aptm-b.ethical-digit.com/packages`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        Authorization: "Bearer **Token**"
      },
      body: formData,
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
  })
```

> response
``
    {
      "success": true,
      "msg": "Package with the name of **package name** has been added to the database !"
    }
``

2. Accessing **get all packages** Route

> code sample

```
    fetch(`https://aptm-b.ethical-digit.com/packages`, {
      method: "GET",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      }
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

- To limit how many addon per page<br />

```
    fetch('https://aptm-b.ethical-digit.com/packages?addonPerPage=**number of addon per page**');
```

- To set which page<br />

```
    fetch('https://aptm-b.ethical-digit.com/packages?page=**page number**');
```

- To filter by name<br />

```
    fetch('https://aptm-b.ethical-digit.com/packages?name=**name**');
```

- To filter by price<br />

```
    fetch('https://aptm-b.ethical-digit.com/packages?price=**price**');
```

- To filter by both name and price<br />

```
    fetch('https://aptm-b.ethical-digit.com/packages?search=**name or price**');
```

- To sort from A to Z<br />

```
    fetch('https://aptm-b.ethical-digit.com/packages?sort=a_to_z');
```

- To sort from Z to A<br />

```
    fetch('https://aptm-b.ethical-digit.com/packages?sort=z_to_a');
```

- To sort from latest creation<br />

```
    fetch('https://aptm-b.ethical-digit.com/packages?sort=createdAt');
```

- To sort from latest updation<br />

```
    fetch('https://aptm-b.ethical-digit.com/packages?sort=updatedAt');
```

> response 
``
    {
      success: true,    
      total_results: 10,
      found_results: 3,
      page: 0,
      entries_per_page: 20,
      packages: { [...], [...], [...] }
    }
``

3. Accessing **get single package** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/packages/:id', {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
``
  {
    success: true,
    addon: { ... }
  }
``

4. Accessing **update Package** Route

> code sample

```
  let form = document.getElementById('form');

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    var formData = new FormData(form);

    fetch(`https://aptm-b.ethical-digit.com/packages/:id`, {
      method: "POST",
      headers: {
        Accept: "application/json",
        Authorization: "Bearer **Token**"
      },
      body: formData,
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
  })
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />
Put any property you want to update about the Packages in the request body.

> response
``
  {
    "success": true,
    "msg": "Package with the id of **id** has been updated !"
  }
`` 
5. Accessing **delete Package** Route

> code sample

```
  fetch('https://aptm-b.ethical-digit.com/packages/:id', {
      method: 'DELETE',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      }
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
``
    {
      "success": true,
      "msg": "Package with the id of **id** has been deleted !"
    }
``


6. Accessing **purchase Package** Route

> code sample

```
  let data = {
    packageId: "63ae55da1f4150ac79b1f9d1",
    userId: "63a944452e02d2aa3a5fef79"
  }

  fetch('https://aptm-b.ethical-digit.com/packages/purchase', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      },
      body: JSON.stringify(data)
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

** Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
``
  {
    success: true,
    msg: "Package purchase successful !"
  }
``


6. Accessing **cancel Package** Route

> code sample

```
  let data = {
    userId: "63a944452e02d2aa3a5fef79"
  }

  fetch('https://aptm-b.ethical-digit.com/packages/cancel', {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer **TOKEN**'
      },
      body: JSON.stringify(data)
  })
  .then(res=>res.json())
  .then(json=>console.log(json));
```

** Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br />

> response
``
  {
    success: true,
    msg: "You have successfully cancel !"
  }
``

-------------------------------------------------------

### **Download List** Route

1. Accessing **get all downloads** Route

> code sample

```
    fetch(`https://aptm-b.ethical-digit.com/downloads`, {
      method: "GET",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      }
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
``
  {
    success: true,
    downloads: { ... }
  }
``
2. Accessing **clear all download** Route

> code sample

```
    fetch(`https://aptm-b.ethical-digit.com/downloads/clear`, {
      method: "DELETE",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      }
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
``
  {
    success: true,
    "msg": "Clearing download successful !"
  }
``


-------------------------------------------------------

### **Favorite List** Route

1. Accessing **get all favorites** Route

> code sample

```
  fetch(`https://aptm-b.ethical-digit.com/favorites`, {
    method: "GET",
    headers: {
      'Content-Type': "application/json",
      Authorization: "Bearer **Token**"
    }
  })
  .then((response) => response.json())
  .then(data => console.log(data))
  .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
``
  {
    success: true,
    downloads: { ... }
  }
``
2. Accessing **clear all favorite** Route

> code sample

```
    fetch(`https://aptm-b.ethical-digit.com/favorites/clear`, {
      method: "DELETE",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      }
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
``
  {
    success: true,
    "msg": "Clearing favorite successful !"
  }
``

-------------------------------------------------------

### **Email Setting** Route

1. Accessing **get email setting** Route

> code sample

```
    fetch(`https://aptm-b.ethical-digit.com/email`, {
      method: "GET",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      }
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
 ``

    {
      success: true,
      email: { ... }
    }

``

2. Accessing **update email setting** Route

> code sample

```
    let data = {
      host: "host",
      port: "port",
      secure: "true or false",
      authUser: "user name",
      authPass: "user password",
      from: "company name or anything else",
    };

    fetch(`https://aptm-b.ethical-digit.com/email`, {
      method: "PATCH",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      },
      body: JSON.stringify(data)
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
 ``

    {
      success: true,
      email: 'email setting has been updated !'
    }

``

-------------------------------------------------------

### **Add** Route

1. Accessing **get add** Route

> code sample

```
    fetch(`https://aptm-b.ethical-digit.com/adds`, {
      method: "GET",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      }
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
``
  {
    success: true,
    adds: { ... }
  }
``

2. Accessing **update add** Route

> code sample

```
    let data = {
      title: "add title",
      link: "add link",
      description: "add description",
      image: "add image"
    };

    fetch(`https://aptm-b.ethical-digit.com/adds`, {
      method: "PATCH",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      },
      body: JSON.stringify(data)
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
``
  {
    success: true,
    msg: 'add has been updated !'
  }
``

---------------------------------------------------------------

### **Notification Setting** Route

1. Accessing **get all notification** Route

> code sample

```
    fetch(`https://aptm-b.ethical-digit.com/notification`, {
      method: "GET",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      }
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
``
  {
    success: true,
    notifications: [{ ... }, { ... }, { ... }]
  }

``

2. Accessing **get single notification** Route

> code sample

```
    fetch(`https://aptm-b.ethical-digit.com/notification/:id`, {
      method: "GET",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      }
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
 ``

    {
      success: true,
      notification: { ... }
    }

``

3. Accessing **update login notification** Route

> code sample

```
    let data = {
      type: "login", // don't change the type to anything else
      subject: "Login Credentials",
      template: "....." // sign up user {{name}} and {{email}} and {{password}}
    };
    fetch(`https://aptm-b.ethical-digit.com/notification/:id`, {
      method: "PATCH",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      },
      body: JSON.stringify(data)
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
``
  {
    success: true,
    msg: "Notification with the id of **id** has been updated !"
  }
``

3. Accessing **password reset notification** Route

> code sample

```
    let data = {
      type: "password reset", // don't change the type to anything else
      subject: "Password Reset",
      template: "....." // sign up user {{name}} and {{otp}} and {{company_name}}
    };
    fetch(`https://aptm-b.ethical-digit.com/notification/:id`, {
      method: "PATCH",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      },
      body: JSON.stringify(data)
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
``
  {
    success: true,
    msg: "Notification with the id of **id** has been updated !"
  }
``


<!-- ### **Google Setting** Route

1. Accessing **get google setting** Route

> code sample

```
    fetch(`https://aptm-b.ethical-digit.com/google`, {
      method: "GET",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      }
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
 ``

    {
      success: true,
      google: { ... }
    }

``

2. Accessing **update google setting** Route

> code sample

```
    let data = {
      clientSecret: "client secret",
      clientId: "client id",
    };

    fetch(`https://aptm-b.ethical-digit.com/google`, {
      method: "PATCH",
      headers: {
        'Content-Type': "application/json",
        Authorization: "Bearer **Token**"
      },
      body: JSON.stringify(data)
    })
    .then((response) => response.json())
    .then(data => console.log(data))
    .catch(e => console.log(e))
```

**Don't forget to add the **Authorization** key and token with the **Bearer** in the request header.** <br /><br />

> response
``
    {
      success: true,
      google: { ... }
    }
`` -->
